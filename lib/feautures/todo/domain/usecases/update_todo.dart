import 'package:dartz/dartz.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/feautures/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/feautures/todo/domain/usecases/params.dart';

class UpdateTodo implements UseCase<Todo, Params>{
  final TodoRepository repository;

  UpdateTodo(this.repository);
  @override
  Future<Either<Failure, Todo>> call(Params params) async {
    // TODO: implement call
    return await repository.updateTodo(params.todo);
  }

}