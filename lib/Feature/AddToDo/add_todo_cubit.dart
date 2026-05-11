import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:to_do_project/Feature/ShowAllToDo/todo_model.dart';
import 'add_todo_repo.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit(this.repo) : super(AddTodoInitial());

  final AddTodoRepo repo;

  Future<void> addTodoHandler({required Map<String, dynamic> data}) async {
    emit(AddTodoLoading());

    final result = await repo.addTodo(data: data);

    result.fold(
      (failure) {
        emit(AddTodoFailure(failure.errMessage));
      },
      (model) {
        emit(AddTodoSuccess(model));
      },
    );
  }
}
