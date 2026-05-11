import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_project/Feature/ShowAllToDo/todo_model.dart';

import 'update_todo_repo.dart';

part 'update_todo_state.dart';

class UpdateTodoCubit extends Cubit<UpdateTodoState> {
  UpdateTodoCubit(this.repo) : super(UpdateTodoInitial());

  final UpdateTodoRepo repo;

  Future<void> updateTodoHandler(int id, Map<String, dynamic> data) async {
    emit(UpdateTodoLoading());

    final result = await repo.updateTodo(id, data);

    result.fold(
      (failure) {
        emit(UpdateTodoFailure(failure.errMessage));
      },
      (model) {
        emit(UpdateTodoSuccess(model));
      },
    );
  }
}
