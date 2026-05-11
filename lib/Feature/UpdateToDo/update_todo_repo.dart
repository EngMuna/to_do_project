import 'package:dartz/dartz.dart';

import 'package:to_do_project/Core/Global/error_failure.dart';
import 'package:to_do_project/Feature/ShowAllToDo/todo_model.dart';

abstract class UpdateTodoRepo {
  Future<Either<Failure, TodoModel>> updateTodo(
    int id,
    Map<String, dynamic> data,
  );
}
