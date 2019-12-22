import 'package:dartz/dartz.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/feautures/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository{
  @override
  Future<Either<Failure, Todo>> addTodo(Todo todo) {
    // TODO: implement addTodo
    return null;
  }

  @override
  Future<Either<Failure, List<Todo>>> clearCompleted() {
    // TODO: implement clearCompleted
    return null;
  }

  @override
  Future<Either<Failure, List<Todo>>> deleteTodo(Todo todo) {
    // TODO: implement deleteTodo
    return null;
  }

  @override
  Future<Either<Failure, List<Todo>>> loadTodos() {
    // TODO: implement loadTodos
    return null;
  }

  @override
  Future<Either<Failure, List<Todo>>> toggleAll() {
    // TODO: implement toggleAll
    return null;
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) {
    // TODO: implement updateTodo
    return null;
  }
  
}