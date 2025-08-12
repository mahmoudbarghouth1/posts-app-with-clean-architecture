import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detal_widgets/post_detail_widget.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({super.key, required this.post});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text("Detail page"));
  }

  _buildBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child:PostDetailWidget(post:post) ,
        ),
    );
  }
}
