import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'delete_todo_repo.dart';

part 'delete_todo_state.dart';

class DeleteTodoCubit extends Cubit<DeleteTodoState> {
  DeleteTodoCubit(this.repo) : super(DeleteTodoInitial());

  final DeleteTodoRepo repo;

  Future<void> deleteTodo(int id) async {
    emit(DeleteTodoLoading());

    final result = await repo.deleteTodo(id);

    result.fold(
      (failure) {
        emit(DeleteTodoFailure(failure.errMessage));
      },
      (success) {
        emit(DeleteTodoSuccess(success.message ?? 'Deleted'));
      },
    );
  }
}
