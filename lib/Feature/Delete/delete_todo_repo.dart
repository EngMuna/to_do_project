import 'package:dartz/dartz.dart';

import 'package:to_do_project/Core/Global/error_failure.dart';
import 'package:to_do_project/Core/Global/global_model.dart';

abstract class DeleteTodoRepo {
  Future<Either<Failure, GlobalModel>> deleteTodo(int id);
}
