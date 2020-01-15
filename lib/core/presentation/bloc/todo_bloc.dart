import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/error/error.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/feautures/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/feautures/todo/domain/usecases/clear_completed.dart';
import 'package:todoapp/feautures/todo/domain/usecases/delete_todo.dart';
import 'package:todoapp/feautures/todo/domain/usecases/load_todos.dart';
import 'package:todoapp/feautures/todo/domain/usecases/params.dart';
import 'package:todoapp/feautures/todo/domain/usecases/toggle_all.dart';
import 'package:todoapp/feautures/todo/domain/usecases/update_todo.dart';
import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final ClearCompleted clearCompleted;
  final DeleteTodo deleteTodo;
  final LoadTodos loadTodos;
  final ToggleAll toggleAll;

  TodoBloc(
      {@required this.addTodo,
      @required this.updateTodo,
      @required this.clearCompleted,
      @required this.deleteTodo,
      @required this.loadTodos,
      @required this.toggleAll});
  @override
  TodoState get initialState => InitialTodoState();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is LoadTodosEvent) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodoE) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodoE) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodoE) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is ToggleAllE) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompletedE) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TodoState> _mapLoadTodosToState() async* {
    yield LoadingTodos();
    final todosOrFailure = await loadTodos(NoParams());
    
    yield* _eitherLoadedOrErrorState(todosOrFailure);
  }

  

  Stream<TodoState> _mapAddTodoToState(AddTodoE event) async*{
    yield LoadingTodos();
    await addTodo(Params(todo: event.todo));
    yield* _mapLoadTodosToState();

  }

  Stream<TodoState>_mapUpdateTodoToState(UpdateTodoE event)async*{
    yield LoadingTodos();
    await updateTodo(Params(todo: event.todo));
    yield* _mapLoadTodosToState();
  }

  Stream<TodoState>_mapDeleteTodoToState(DeleteTodoE event) async*{
    yield LoadingTodos();
    await deleteTodo(Params(todo: event.todo));
    yield* _mapLoadTodosToState();
  }

  Stream<TodoState>_mapToggleAllToState() async*{
    yield LoadingTodos();
    await toggleAll(NoParams());
    yield* _mapLoadTodosToState();
  }

  Stream<TodoState>_mapClearCompletedToState() async*{
    yield LoadingTodos();
    await clearCompleted(NoParams());
    yield* _mapLoadTodosToState();
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.toString();
  }


  Stream<TodoState> _eitherLoadedOrErrorState(
    Either<Failure, List<Todo>> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => TodoError(message: _mapFailureToMessage(failure)),
      (todos) => LoadedTodoState(todos),
    );
  }
}
