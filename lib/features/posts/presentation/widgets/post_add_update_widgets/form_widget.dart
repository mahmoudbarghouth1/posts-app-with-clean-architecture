import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delet_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_add_update_widgets/elevated_button_icon_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_add_update_widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/widgets.dart';

class FormWidget extends StatefulWidget {
  final bool isupdate;
  final Post? post;
  const FormWidget({super.key, required this.isupdate, required this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titlecontroler = TextEditingController();
  final TextEditingController _bodycontroler = TextEditingController();
  @override
  void initState() {
    if (widget.isupdate) {
      _titlecontroler.text = widget.post!.title;
      _bodycontroler.text = widget.post!.body;
    }
    super.initState();
  }

  void validationFormThenAddDeletePost() {
    final isValide = _formKey.currentState!.validate();

    if (isValide) {
      final post = Post(id: widget.isupdate ? widget.post!.id : null, title: _titlecontroler.text, body: _bodycontroler.text);
      BlocProvider.of<AddDeletUpdatePostBloc>(context).add(AddPostEvents(post: post));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFieldWidget(name: "title", multiLine: false, controller: _titlecontroler),

          TextFieldWidget(name: "body", multiLine: true, controller: _bodycontroler),
          ElevatedButtonIconWidget(onpress:validationFormThenAddDeletePost,icon:widget.isupdate,label:widget.isupdate),
          
        ],
      ),
    );
  }
}
