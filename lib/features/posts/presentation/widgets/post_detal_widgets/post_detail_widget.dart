import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';

import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detal_widgets/elevated_delete_button_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detal_widgets/elevated_edit_button_widget.dart';
import 'package:flutter/material.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            post.title,
            style: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(height: 50),
          Text(
            post.body,
            style: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedEditButtonWidget(post:post),
              
              ElevatedDeleteButtonWidget(postId:post.id!),
             
            ],
          ),
        ],
      ),
    );
  }

 
}
