import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_project/Core/Utiles/api_services.dart';
import 'package:to_do_project/Feature/ShowAllToDo/show_all_todo_cubit.dart';
import 'package:to_do_project/Feature/ShowAllToDo/show_all_todo_repo.dart';
import 'package:to_do_project/Feature/ShowAllToDo/show_all_todo_repo_impl.dart';
import 'package:to_do_project/Feature/Delete/delete_todo_cubit.dart';
import 'package:to_do_project/Feature/ToggleToDo/toggle_todo_cubit.dart';
import 'package:to_do_project/Feature/UpdateToDo/update_todo_cubit.dart';

import 'package:to_do_project/Feature/Delete/delete_todo_repo.dart';
import 'package:to_do_project/Feature/Delete/delete_todo_repo_impl.dart';

import 'package:to_do_project/Feature/ToggleToDo/toggle_todo_repo.dart';
import 'package:to_do_project/Feature/ToggleToDo/toggle_todo_repo_impl.dart';

import 'package:to_do_project/Feature/UpdateToDo/update_todo_repo.dart';
import 'package:to_do_project/Feature/UpdateToDo/update_todo_repo_impl.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  // 1
  locator.registerSingleton<SharedPreferences>(sharedPreferences);

  // 2
  locator.registerLazySingleton<Dio>(() => Dio());

  // 3
  locator.registerLazySingleton<ApiService>(
    () => ApiService(locator<Dio>(), locator<SharedPreferences>()),
  );

  locator.registerFactory<GetTodoRepo>(
    () => GetTodoRepoImpl(locator<ApiService>()),
  );

  locator.registerFactory<GetTodoCubit>(
    () => GetTodoCubit(locator<GetTodoRepo>()),
  );
  locator.registerFactory<DeleteTodoRepo>(
    () => DeleteTodoRepoImpl(locator<ApiService>()),
  );

  locator.registerFactory<DeleteTodoCubit>(
    () => DeleteTodoCubit(locator<DeleteTodoRepo>()),
  );
  locator.registerFactory<ToggleTodoRepo>(
    () => ToggleTodoRepoImpl(locator<ApiService>()),
  );

  locator.registerFactory<ToggleTodoCubit>(
    () => ToggleTodoCubit(locator<ToggleTodoRepo>()),
  );
  locator.registerFactory<UpdateTodoRepo>(
    () => UpdateTodoRepoImpl(locator<ApiService>()),
  );

  locator.registerFactory<UpdateTodoCubit>(
    () => UpdateTodoCubit(locator<UpdateTodoRepo>()),
  );
}
