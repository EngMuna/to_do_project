import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:to_do_project/Core/Utiles/api_services.dart';
import 'package:to_do_project/Core/Utiles/endpoin.dart';
import 'package:to_do_project/Feature/AddToDo/add_todo_repo.dart';
import 'package:to_do_project/Core/Global/error_failure.dart';
import 'package:to_do_project/Feature/ShowAllToDo/todo_model.dart';

class AddTodoRepoImpl implements AddTodoRepo {
  final ApiService apiService;

  AddTodoRepoImpl(this.apiService);

  @override
  Future<Either<Failure, TodoModel>> addTodo({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: EndPoint.deleteTodos,
        data: data,
      );

      final model = TodoModel.fromJson(response);

      return right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure('Unexpected error occurred'));
    }
  }
}
