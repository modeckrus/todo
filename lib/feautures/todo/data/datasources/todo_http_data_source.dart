import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapp/core/error/exception.dart';
import 'package:todoapp/feautures/todo/data/models/todo_model.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

import 'package:http/http.dart' as http;

abstract class TodoHttpDataSource {
  Future<Todo> addTodo(Todo todo);
  Future<List<Todo>> clearCompleted();
  Future<List<Todo>> deleteTodo(Todo todo);
  Future<List<Todo>> loadTodos();
  Future<List<Todo>> toggleAll();
  Future<Todo> updateTodo(Todo todo);
}

class TodoHttpDataSourceImpl implements TodoHttpDataSource {
  final http.Client client;
  TodoHttpDataSourceImpl({@required this.client});
  @override
  Future<Todo> addTodo(Todo todo) async {
    final result = await client.post(
      'http://localhost:8080/api/loadtodos',
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'task': todo.task,
        'id': todo.id,
        'note': todo.note,
        'complete': todo.complete
      },
    );
    if (result.statusCode == 200) {
      return TodoModel.fromJson(json.decode(result.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Todo>> clearCompleted() async {
    final response = await client.get(
      'http://localhost:8080/api/clearcompleted',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return TodosModel.fromJson(json.decode(response.body)).todos;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Todo>> deleteTodo(Todo todo) async {
    final response = await client.post(
      'http://localhost:8080/api/deletetodo',
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'task': todo.task,
        'id': todo.id,
        'note': todo.note,
        'complete': todo.complete
      },
    );
    if (response.statusCode == 200) {
      return TodosModel.fromJson(json.decode(response.body)).todos;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Todo>> loadTodos() async {
    final response = await client.get(
      'http://localhost:8080/api/loadtodos',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if(response.statusCode == 200){
      return TodosModel.fromJson(json.decode(response.body)).todos;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<Todo>> toggleAll() async{
    final response = await client.get(
      'http://localhost:8080/api/toggleAll',
          headers: {
            'Content-Type': 'application/json',
          },
    );
    if(response.statusCode == 200){
      return TodosModel.fromJson(json.decode(response.body)).todos;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Todo> updateTodo(Todo todo) async{
    final result = await client.post(
      'http://localhost:8080/api/updatetodo',
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'task': todo.task,
        'id': todo.id,
        'note': todo.note,
        'complete': todo.complete
      },
    );
    if (result.statusCode == 200) {
      return TodoModel.fromJson(json.decode(result.body));
    } else {
      throw ServerException();
    }
  }
}
