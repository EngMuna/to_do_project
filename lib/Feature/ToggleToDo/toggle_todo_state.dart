part of 'toggle_todo_cubit.dart';

sealed class ToggleTodoState extends Equatable {
  const ToggleTodoState();

  @override
  List<Object> get props => [];
}

final class ToggleTodoInitial extends ToggleTodoState {}

final class ToggleTodoLoading extends ToggleTodoState {}

final class ToggleTodoSuccess extends ToggleTodoState {
  final TodoModel todo;

  const ToggleTodoSuccess(this.todo);

  @override
  List<Object> get props => [todo];
}

final class ToggleTodoFailure extends ToggleTodoState {
  final String errMessage;

  const ToggleTodoFailure(this.errMessage);
}
