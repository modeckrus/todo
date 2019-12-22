import 'package:flutter/material.dart';
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

class TodoHttpDataSourceImpl implements TodoHttpDataSource{
  final http.Client client;
  TodoHttpDataSourceImpl({@required this.client});
  @override
  Future<Todo> addTodo(Todo todo) {
    // TODO: implement addTodo
    return null;
  }

  @override
  Future<List<Todo>> clearCompleted() {
    // TODO: implement clearCompleted
    return null;
  }

  @override
  Future<List<Todo>> deleteTodo(Todo todo) {
    // TODO: implement deleteTodo
    return null;
  }

  @override
  Future<List<Todo>> loadTodos() {
    // TODO: implement loadTodos
    return null;
  }

  @override
  Future<List<Todo>> toggleAll() {
    // TODO: implement toggleAll
    return null;
  }

  @override
  Future<Todo> updateTodo(Todo todo) {
    // TODO: implement updateTodo
    return null;
  }

}