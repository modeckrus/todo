import 'package:dartz/dartz.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>>
      loadTodos(); //Load all todos, return list of todos
  Future<Either<Failure, Todo>> addTodo(Todo todo); //Add todos, if success return todo
  Future<Either<Failure, Todo>>
      updateTodo(Todo todo); //Update todo, if success return todo
  Future<Either<Failure, List<Todo>>>
      deleteTodo(Todo todo); //Delete todo, if success return list of todos
  Future<Either<Failure, List<Todo>>>
      clearCompleted(); //Clear Completed todos, if success return list of todos
  Future<Either<Failure, List<Todo>>>
      toggleAll(); //Make all todos as completed, if success return list of todos
}
