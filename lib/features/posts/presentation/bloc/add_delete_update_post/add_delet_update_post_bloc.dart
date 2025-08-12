import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/add_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/delet_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/update_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_delet_update_post_event.dart';
part 'add_delet_update_post_state.dart';

class AddDeletUpdatePostBloc extends Bloc<AddDeletUpdatePostEvent, AddDeletUpdatePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatepost;
  final DeletPostUseCae deletPost;
  AddDeletUpdatePostBloc({required this.addPost, required this.updatepost, required this.deletPost}) : super(AddDeletUpdatePostInitial()) {
    on<AddDeletUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvents) {
        emit(LodingAddDeletUpdatePostState());
        final failureOrDoneMessage = await addPost(event.post);
        failureOrDoneMessage.fold(
          (failure) {
            emit(ErrorAddDeletUpdatePostState(message: "Try Again Later"));
          },
          (unit) {
            emit(MessageAddDeletUpdatePostState(message: "Post Add successfully"));
          },
        );
      } else if (event is UpdatePostEvents) {
        emit(LodingAddDeletUpdatePostState());
        final failureOrDoneMessage = await updatepost(event.post);
        failureOrDoneMessage.fold(
          (failure) {
            emit(ErrorAddDeletUpdatePostState(message: "Try Again Later"));
          },
          (unit) {
            emit(MessageAddDeletUpdatePostState(message: "Post Updated successfully"));
          },
        );
      } else if (event is DeletePostEvents) {
        emit(LodingAddDeletUpdatePostState());
        final failureOrDoneMessage = await deletPost(event.postId);
        failureOrDoneMessage.fold(
          (failure) {
            emit(ErrorAddDeletUpdatePostState(message: "Try Again Later"));
          },
          (unit) {
            emit(MessageAddDeletUpdatePostState(message: "Post Deleted successfully"));
          },
        );
      }
    });
  }
}
