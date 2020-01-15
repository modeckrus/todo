import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/error/exception.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/core/network/network_info.dart';
import 'package:todoapp/feautures/todo/data/datasources/todo_http_data_source.dart';
import 'package:todoapp/feautures/todo/data/datasources/todo_local_data_source.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/feautures/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository{
  final TodoLocalDataSource localDataSource;
  final TodoHttpDataSource http;
  final NetworkInfo networkInfo;
  TodoRepositoryImpl({
    @required this.localDataSource,
    @required this.http,
    @required this.networkInfo
  });
  @override
  Future<Either<Failure, Todo>> addTodo(Todo todo)async{
    if(await networkInfo.isConnected){
      try{
        final ntodo = await http.addTodo(todo);
        localDataSource.addTodo(ntodo);
        return Right(ntodo);
      }on ServerException{
        return Left(ServerFailure(message: 'Add todo(Server return non 200 code): '));
      }
    }else{
      try{
        await localDataSource.addTodo(todo);
        return Right(todo);
      }on LocalException{
        return Left(LocalFailure(message: 'Add Todo(Local Error): '));
      }
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> clearCompleted() async{
    if(await networkInfo.isConnected){
      try{
        final result = await http.clearCompleted();
        await localDataSource.clearCompleted();
        return Right(result);
      }on ServerException{
        return Left(ServerFailure(message: 'Clear Completed(Server return non 200 code): '));
      }
    }else{
      try{
        return Right(await localDataSource.clearCompleted());
      }on LocalException{
        return Left(LocalFailure(message: 'Clear Completed(Local Error): '));
      }
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> deleteTodo(Todo todo) async{
    if(await networkInfo.isConnected){
      try{
        final result = await http.deleteTodo(todo);
        await localDataSource.deleteTodo(todo);
        return Right(result);
      }on ServerException{
        return Left(ServerFailure(message: 'Delete Todo(Server return non 200 code): '));
      }
    }else{
      try{
        return Right(await localDataSource.deleteTodo(todo));
      }on LocalException{
        return Left(LocalFailure(message: 'Delete Todo(Local Error): '));
      }
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> loadTodos() async{
    if(await networkInfo.isConnected){
      try{
        return Right(await http.loadTodos());
      }on ServerException{
        return Left(ServerFailure(message: 'Load Todos(Server return non 200 code): '));
      }
    }else{
      try{
        return Right(await localDataSource.loadTodos());
      }on LocalException{
        return Left(LocalFailure(message: 'Load Todos(Local Error): '));
      }
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> toggleAll() async{
    if(await networkInfo.isConnected){
      try{
        final result = await http.toggleAll();
        await localDataSource.toggleAll();
        return Right(result);
      }on ServerException{
        return Left(ServerFailure(message: 'Toggle All(Server return non 200 code): '));
      }
    }else{
      try{
        return Right(await localDataSource.toggleAll());
      }on LocalException{
        return Left(LocalFailure(message: 'Toggle All(Local Error): '));
      }
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async{
    if(await networkInfo.isConnected){
      try{
        final ntodo = await http.updateTodo(todo);
        localDataSource.updateTodo(ntodo);
        return Right(ntodo);
      }on ServerException{
        return Left(ServerFailure(message: 'Update Todo(Server return non 200 code): '));
      }
    }else{
      try{
        await localDataSource.updateTodo(todo);
        return Right(todo);
      }on LocalException{
        return Left(LocalFailure(message: 'Update Todo(Local Error): '));
      }
    }
  }
  
}