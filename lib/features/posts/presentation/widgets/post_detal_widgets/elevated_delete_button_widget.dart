
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delet_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detal_widgets/delete_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/snake_bar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';

class ElevatedDeleteButtonWidget extends StatelessWidget {
  final int postId;
  const ElevatedDeleteButtonWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => deleteDialog(context),
      icon: Icon(Icons.delete, color: Colors.white),
      label: Text("Delete", style: TextStyle(color: Colors.white)),
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
    );
  }
   void deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddDeletUpdatePostBloc, AddDeletUpdatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeletUpdatePostState) {
              SnakeBarMessage().showSuccessSnakeBar(message: state.message, context: context);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => PostsPage()), (route) => false);
            } else if (state is ErrorAddDeletUpdatePostState) {
              Navigator.pop(context);
              SnakeBarMessage().showFailureSnakeBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LodingAddDeletUpdatePostState) {
              return AlertDialog(title: LoadingWidget());
            }
            return DeleteDialogWidget(postId:postId);
          },
        );
      },
    );
  }
}

