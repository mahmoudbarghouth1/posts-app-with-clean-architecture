import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/posts_page_widgets/messag_display_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/posts_page_widgets/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButtons(context),
    );
  }

  AppBar _buildAppBar() => AppBar(title: Text("Posts"));

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingpostsState) {
            return LoadingWidget();
          } else if (state is LodedPostsState) {
            return RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: PostListWidget(posts: state.posts),
            );
          } else if (state is ErrorePostsState) {
            return MessagDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }

  Widget _buildFloatingButtons(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => PostAddUpdatePage(isupdate: false)),
        );
      },
      child: Icon(Icons.add),
    );
  }

  Future<void> _refresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
