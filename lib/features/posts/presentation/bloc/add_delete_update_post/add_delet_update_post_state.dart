part of 'add_delet_update_post_bloc.dart';

sealed class AddDeletUpdatePostState extends Equatable {
  const AddDeletUpdatePostState();

  @override
  List<Object> get props => [];
}

final class AddDeletUpdatePostInitial extends AddDeletUpdatePostState {}

class LodingAddDeletUpdatePostState extends AddDeletUpdatePostState {}

class ErrorAddDeletUpdatePostState extends AddDeletUpdatePostState {
  final String message;

  const ErrorAddDeletUpdatePostState({required this.message});
  @override
  List<Object> get props => [message];
}
class MessageAddDeletUpdatePostState extends AddDeletUpdatePostState {
  final String message;

  const MessageAddDeletUpdatePostState({required this.message});
  @override
  List<Object> get props => [message];
}