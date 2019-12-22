import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/feautures/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/feautures/todo/domain/usecases/params.dart';

class DeleteTodo implements UseCase<List<Todo>, Params>{
  final TodoRepository repository;

  DeleteTodo(this.repository);
  @override
  Future<Either<Failure, List<Todo>>>call(Params params) async {
    // TODO: implement call
    return await repository.deleteTodo(params.todo);
  }
  
}