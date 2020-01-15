import 'package:equatable/equatable.dart';
import 'package:todoapp/core/presentation/bloc/bloc.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}
class LoadTodosEvent{}

class AddTodoE extends TodoEvent{
  final Todo todo;

  AddTodoE(this.todo);
  
  @override
  // TODO: implement props
  List<Object> get props => [todo];

  @override
  String toString() => 'AddTodo { todo: $todo }';
}

class UpdateTodoE extends TodoEvent{
  final Todo todo;

  UpdateTodoE(this.todo);
  @override
  // TODO: implement props
  List<Object> get props => [todo];

  @override
  String toString() => 'AddTodo { todo: $todo }';
}

class DeleteTodoE extends TodoEvent{
  final Todo todo;

  DeleteTodoE(this.todo);
  @override
  // TODO: implement props
  List<Object> get props => [todo];

  @override
  String toString() => 'AddTodo { todo: $todo }';
}

class ClearCompletedE extends TodoEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
  @override
  String toString() => 'ClearCompleted';
}

class ToggleAllE extends TodoEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
  @override
  String toString() => 'ToggleAll';
}