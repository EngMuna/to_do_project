part of 'delete_todo_cubit.dart';

sealed class DeleteTodoState extends Equatable {
  const DeleteTodoState();

  @override
  List<Object> get props => [];
}

final class DeleteTodoInitial extends DeleteTodoState {}

final class DeleteTodoLoading extends DeleteTodoState {}

final class DeleteTodoSuccess extends DeleteTodoState {
  final String message;

  const DeleteTodoSuccess(this.message);
}

final class DeleteTodoFailure extends DeleteTodoState {
  final String errMessage;

  const DeleteTodoFailure(this.errMessage);
}
