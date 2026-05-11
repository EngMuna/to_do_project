import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_project/Feature/ShowAllToDo/show_all_todo_repo.dart';
import 'package:to_do_project/Feature/ShowAllToDo/todo_model.dart';

part 'show_all_todo_state.dart';

class GetTodoCubit extends Cubit<GetTodoState> {
  List<TodoModel> _todos = [];
  GetTodoCubit(this.repo) : super(GetTodoInitial());

  final GetTodoRepo repo;

  Future<void> getTodosHandler() async {
    emit(GetTodoLoading());

    final result = await repo.getTodos();

    result.fold(
      (failure) {
        emit(GetTodoFailure(failure.errMessage));
      },
      (todos) {
        // emit(GetTodoSuccess(todos));
        _todos = todos;
        emit(GetTodoSuccess(List.from(_todos)));
      },
    );
  }

  void deleteLocal(int id) {
    _todos.removeWhere((e) => e.id == id);
    emit(GetTodoSuccess(List.from(_todos)));
  }

  void toggleLocal(int id) {
    final index = _todos.indexWhere((e) => e.id == id);

    if (index == -1) return; // 🔥 حماية من الكراش

    final old = _todos[index];

    _todos[index] = TodoModel(
      userId: old.userId,
      id: old.id,
      title: old.title,
      completed: !old.completed,
    );

    emit(GetTodoSuccess(List.from(_todos)));
  }

  void updateLocal(int id, Map<String, dynamic> data) {
    final index = _todos.indexWhere((e) => e.id == id);

    if (index == -1) return;

    final old = _todos[index];

    _todos[index] = TodoModel(
      userId: old.userId,
      id: old.id,
      title: data['title'] ?? old.title,
      completed: data['completed'] ?? old.completed,
    );

    emit(GetTodoSuccess(List.from(_todos)));
  }
}
