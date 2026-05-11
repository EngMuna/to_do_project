part of 'update_todo_cubit.dart';

sealed class UpdateTodoState extends Equatable {
  const UpdateTodoState();

  @override
  List<Object> get props => [];
}

final class UpdateTodoInitial extends UpdateTodoState {}

final class UpdateTodoLoading extends UpdateTodoState {}

final class UpdateTodoSuccess extends UpdateTodoState {
  final TodoModel todo;

  const UpdateTodoSuccess(this.todo);
}

final class UpdateTodoFailure extends UpdateTodoState {
  final String errMessage;

  const UpdateTodoFailure(this.errMessage);
}
