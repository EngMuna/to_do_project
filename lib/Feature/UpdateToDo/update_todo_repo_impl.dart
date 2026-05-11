import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:to_do_project/Core/Utiles/api_services.dart';
import 'package:to_do_project/Core/Utiles/endpoin.dart';
import 'package:to_do_project/Core/Global/error_failure.dart';
import 'package:to_do_project/Feature/ShowAllToDo/todo_model.dart';
import 'package:to_do_project/Feature/UpdateToDo/update_todo_repo.dart';

class UpdateTodoRepoImpl implements UpdateTodoRepo {
  final ApiService apiService;

  UpdateTodoRepoImpl(this.apiService);

  @override
  Future<Either<Failure, TodoModel>> updateTodo(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await apiService.put(
        endPoint: '${EndPoint.updateTodos}/$id',
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
