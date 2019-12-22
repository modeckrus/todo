import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

abstract class TodoLocalDataSource {

  Future<Todo> addTodo(Todo todo);
  Future<List<Todo>> clearCompleted();
  Future<List<Todo>> deleteTodo(Todo todo);
  Future<List<Todo>> loadTodos();
  Future<List<Todo>> toggleAll();
  Future<Todo> updateTodo(Todo todo);
}