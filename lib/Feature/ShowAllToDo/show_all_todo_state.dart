part of 'show_all_todo_cubit.dart';

sealed class GetTodoState extends Equatable {
  const GetTodoState();

  @override
  List<Object> get props => [];
}

final class GetTodoInitial extends GetTodoState {}

final class GetTodoLoading extends GetTodoState {}

final class GetTodoSuccess extends GetTodoState {
  final List<TodoModel> todos;

  const GetTodoSuccess(this.todos);

  @override
  List<Object> get props => [todos];
}

final class GetTodoFailure extends GetTodoState {
  final String errMessage;

  const GetTodoFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
