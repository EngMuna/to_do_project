import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_project/Feature/ShowAllToDo/todo_model.dart';

import 'toggle_todo_repo.dart';

part 'toggle_todo_state.dart';

class ToggleTodoCubit extends Cubit<ToggleTodoState> {
  ToggleTodoCubit(this.repo) : super(ToggleTodoInitial());

  final ToggleTodoRepo repo;

  Future<void> toggleTodoHandler({required TodoModel todo}) async {
    emit(ToggleTodoLoading());

    final updatedData = {
      "userId": todo.userId,
      "id": todo.id,
      "title": todo.title,
      "completed": !todo.completed,
    };

    final result = await repo.toggleTodo(id: todo.id, data: updatedData);

    result.fold(
      (failure) {
        emit(ToggleTodoFailure(failure.errMessage));
      },
      (updatedTodo) {
        emit(ToggleTodoSuccess(updatedTodo));
      },
    );
  }
}
