import 'package:dartz/dartz.dart';

import 'package:to_do_project/Core/Global/error_failure.dart';
import 'package:to_do_project/Feature/ShowAllToDo/todo_model.dart';

abstract class AddTodoRepo {
  Future<Either<Failure, TodoModel>> addTodo({
    required Map<String, dynamic> data,
  });
}
