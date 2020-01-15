import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/feautures/todo/data/respositories/todo_repository_impl.dart';
import 'package:todoapp/feautures/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/feautures/todo/domain/usecases/clear_completed.dart';
import 'package:todoapp/feautures/todo/domain/usecases/delete_todo.dart';
import 'package:todoapp/feautures/todo/domain/usecases/load_todos.dart';
import 'package:todoapp/feautures/todo/domain/usecases/toggle_all.dart';
import 'package:todoapp/feautures/todo/domain/usecases/update_todo.dart';

import 'core/network/network_info.dart';
import 'feautures/todo/data/datasources/todo_http_data_source.dart';
import 'feautures/todo/data/datasources/todo_local_data_source.dart';
import 'feautures/todo/domain/repositories/todo_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Todo
  // Bloc

  // Use cases
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => ClearCompleted(sl()));
    sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => LoadTodos(sl()));
    sl.registerLazySingleton(() => ToggleAll(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      http: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TodoHttpDataSource>(
    () => TodoHttpDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
