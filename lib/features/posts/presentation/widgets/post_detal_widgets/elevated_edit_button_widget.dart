import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:flutter/material.dart';

class ElevatedEditButtonWidget extends StatelessWidget {
  final Post post;

  const ElevatedEditButtonWidget({super.key, required this.post});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => PostAddUpdatePage(isupdate: true, post: post)));
      },
      icon: Icon(Icons.edit, color: Colors.white),
      label: Text("Edit", style: TextStyle(color: Colors.white)),
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
    );
  }
}
