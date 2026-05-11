import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:to_do_project/Core/Utiles/api_services.dart';
import 'package:to_do_project/Core/Utiles/endpoin.dart';
import 'package:to_do_project/Feature/ShowAllToDo/show_all_todo_repo.dart';
import 'package:to_do_project/Core/Global/error_failure.dart';
import 'package:to_do_project/Feature/ShowAllToDo/todo_model.dart';

class GetTodoRepoImpl implements GetTodoRepo {
  final ApiService apiService;

  GetTodoRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<TodoModel>>> getTodos() async {
    try {
      final response = await apiService.get(endPoint: EndPoint.showTodos);

      final dataList = response as List;

      final todos = dataList.map((e) => TodoModel.fromJson(e)).toList();

      return right(todos);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure('Unexpected error occurred'));
    }
  }
}
