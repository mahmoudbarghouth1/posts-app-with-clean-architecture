import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/use%20case/get_all_posts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<GetAllPostsEvent>(_onGetAllPostsEvent);
    on<RefreshPostsEvent>(_onRefreshPostsEvent);
  }

  Future<void> _onGetAllPostsEvent(GetAllPostsEvent event, Emitter<PostsState> emit) async {
    emit(LoadingpostsState());
    final result = await getAllPosts();
    result.fold(
      (failure) => emit(ErrorePostsState(message: _mapFailureToMessage(failure))),
      (posts) => emit(LodedPostsState(posts: posts)),
    );
  }

  Future<void> _onRefreshPostsEvent(RefreshPostsEvent event, Emitter<PostsState> emit) async {
    emit(LoadingpostsState());
    final result = await getAllPosts();
    result.fold(
      (failure) => emit(ErrorePostsState(message: _mapFailureToMessage(failure))),
      (posts) => emit(LodedPostsState(posts: posts)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return "Please try again later";
      case OffLineFailure _:
        return "Please check your internet connection";
      case EmptyCashFailure _:
        return "No data found";
      default:
        return "Unexpected error! Please try again";
    }
  }
}



// class PostsBloc extends Bloc<PostsEvent, PostsState> {
  
//   final GetAllPostsUseCase getAllPosts;
//   PostsBloc({ required this.getAllPosts})
//     : super(PostsInitial()) {
//     on<PostsEvent>((event, emit) async {
//       if (event is GetAllPostsEvent) {
//         emit(LoadingpostsState());
//         final posts = await getAllPosts(); // some thing wrong
//         posts.fold(
//           (falure) {
//             emit(ErrorePostsState(message: _mapFalureToMessage(falure)));
//           },
//           (posts) {
//             emit(LodedPostsState(posts: posts));
//           },
//         );
//       } else if (event is RefreshPostsEvent) {
//         emit(LoadingpostsState());
//         final posts = await getAllPosts( ); // some thing wrong
//         posts.fold(
//           (falure) {
//             emit(ErrorePostsState(message: _mapFalureToMessage(falure)));
//           },
//           (posts) {
//             emit(LodedPostsState(posts: posts));
//           },
//         );
//       }
//     });
//   }
//   String _mapFalureToMessage(Failure falure) {
//     switch (falure.runtimeType) {
//       case ServerFailure:
//         return "please try again later";
//       case OffLineFailure:
//         return " please chec your internet connection ";
//       case EmptyCashFailure:
//         return " no data";

//       default:
//         return " unexcpecte errore ! please try again ";
//     }
//   }
// }
