import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/presentation/bloc/bloc.dart';

import '../../../feautures/todo/domain/entities/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  @override
  List<Object> get props => [];
}

class InitialTodoState extends TodoState {
  @override
  List<Object> get props => [];
}

class LoadedTodoState extends TodoState{
  final List<Todo> todos;
  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'LoadedTodoState { todos: $todos }';
  
  const LoadedTodoState([this.todos = const []]);
}
class LoadingTodos extends TodoState{}
class TodosNotLoaded extends TodoState{}
class TodoError extends TodoState{
  final String message;
  const TodoError({
    @required this.message
  });
  @override
  List<Object> get props => [message];
  @override
  String toString() => 'Error { message: $message }';
}

