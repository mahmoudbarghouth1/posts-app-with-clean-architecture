part of 'add_delet_update_post_bloc.dart';

sealed class AddDeletUpdatePostEvent extends Equatable {
  const AddDeletUpdatePostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvents extends AddDeletUpdatePostEvent {
  final Post post;

  const AddPostEvents({required this.post});
  @override
  List<Object> get props => [post];
}

class DeletePostEvents extends AddDeletUpdatePostEvent {
   final int postId;

  const DeletePostEvents({required this.postId});
  @override
  List<Object> get props => [postId];
}

class UpdatePostEvents extends AddDeletUpdatePostEvent {
   final Post post;

  const UpdatePostEvents({required this.post});
  @override
  List<Object> get props => [post];
}
