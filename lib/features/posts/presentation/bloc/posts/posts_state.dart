part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

class LoadingpostsState extends PostsState {}

class LodedPostsState extends PostsState {
  final List<Post> posts;

  const LodedPostsState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class ErrorePostsState extends PostsState {
  final String message;

  const ErrorePostsState({required this.message});
  @override
  List<Object> get props => [message];
}
