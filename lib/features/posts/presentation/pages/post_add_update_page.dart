import 'package:clean_architecture_posts_app/core/util/snake_bar_message.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delet_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_add_update_widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/widgets.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isupdate;
  const PostAddUpdatePage({super.key, this.post, required this.isupdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body(context));
  }

  AppBar _appBar() {
    return AppBar(title: Text(isupdate ? "Edit Post " : "Add Post "));
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: BlocConsumer<AddDeletUpdatePostBloc, AddDeletUpdatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeletUpdatePostState) {
              SnakeBarMessage().showSuccessSnakeBar(
                message: state.message,
                context: context,
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => PostsPage()),
                (route) => false,
              );
            } else if (state is ErrorAddDeletUpdatePostState) {
              SnakeBarMessage().showFailureSnakeBar(
                message: state.message,
                context: context,
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => PostsPage()),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingpostsState) {
              return LoadingWidget();
            }
            return FormWidget(isupdate: isupdate, post: isupdate ? post : null);
          },
        ),
      ),
    );
  }
}
