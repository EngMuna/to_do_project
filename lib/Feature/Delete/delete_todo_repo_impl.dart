import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:to_do_project/Core/Utiles/api_services.dart';
import 'package:to_do_project/Core/Utiles/endpoin.dart';
import 'package:to_do_project/Feature/Delete/delete_todo_repo.dart';
import 'package:to_do_project/Core/Global/error_failure.dart';
import 'package:to_do_project/Core/Global/global_model.dart';

class DeleteTodoRepoImpl implements DeleteTodoRepo {
  final ApiService apiService;

  DeleteTodoRepoImpl(this.apiService);

  @override
  Future<Either<Failure, GlobalModel>> deleteTodo(int id) async {
    try {
      final response = await apiService.delete(
        endPoint: '${EndPoint.todos}/$id',
      );

      final model = GlobalModel.fromJson(response);

      return right(model);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure('Unexpected error occurred'));
    }
  }
}
