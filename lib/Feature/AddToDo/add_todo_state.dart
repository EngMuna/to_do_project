part of 'add_todo_cubit.dart';

sealed class AddTodoState extends Equatable {
  const AddTodoState();

  @override
  List<Object> get props => [];
}

final class AddTodoInitial extends AddTodoState {}

final class AddTodoLoading extends AddTodoState {}

final class AddTodoSuccess extends AddTodoState {
  final TodoModel todo;

  const AddTodoSuccess(this.todo);

  @override
  List<Object> get props => [todo];
}

final class AddTodoFailure extends AddTodoState {
  final String errMessage;

  const AddTodoFailure(this.errMessage);
}
