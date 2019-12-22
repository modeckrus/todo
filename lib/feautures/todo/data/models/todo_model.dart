import 'package:flutter/material.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

class TodoModel extends Todo{
  TodoModel(String task, {
    @required String id,
    @required String note,
    @required bool complete, 
  }):super(task, id: id, note: note, complete: complete);
  factory TodoModel.fromJson(Map<String, dynamic> json){
    return TodoModel(
      json['task'],
      id: json['id'],
      note: json['note'],
      complete: (json['complete'] as bool)
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'task' : task,
      'id' : id,
      'note':note,
      'complete': complete,
    };
  }
}
class TodosModel {
  final List<Todo> todos;
  TodosModel(this.todos);
  //List<Todo> todos = [];
  factory TodosModel.fromJson(dynamic json){
    List<Todo> todos = [];
    for(var td in json){
      var todo = TodoModel.fromJson(td);
      todos.add(todo);
    }
    return TodosModel(todos);
  }
  dynamic toJson(){
    return todos;
  }
}