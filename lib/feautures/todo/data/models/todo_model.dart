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