

import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:sembast/sembast.dart';
import 'package:test/test.dart';
import 'package:todoapp/core/db/mydatabase.dart';
import 'package:todoapp/core/db/tododao.dart';
import 'package:todoapp/feautures/todo/data/datasources/todo_local_data_source.dart';
import 'package:todoapp/feautures/todo/data/models/todo_model.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

import '../../fixtures/fixture.dart';

class TodoDaoMock extends Mock implements TodoDaoImplement{}

void main(){
  TodoLocalDataSourceImpl dataSource;
  TodoDaoMock dataBase;

  setUp((){
    dataBase = TodoDaoMock();
    dataSource = TodoLocalDataSourceImpl(dataBase);
  });
  group('addTodo', (){
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    test(
    'should call dataBase.add when we try save it in database',
    ()async{
    //arrange
    when(dataBase.add(any)).
    thenAnswer((_)async => null);
    //act
    dataSource.addTodo(tTodo);
    //assert 
    verify(dataBase.add(tTodo));
    },);
  });
  
  group('clearCompleted', (){
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    final tTodos = [tTodoModel];
    test(
    'should call dataBase.clearCompleted when we try clear completed todos',
    ()async{
    //arrange
    when(dataBase.find(any)).
    thenAnswer((_)async => tTodos);
    when(dataBase.deleteAll(any));
    //act
    dataSource.clearCompleted();
    //assert
    //verify(dataBase.find(Finder()));

    },);
    test(
    'should return todos when we try clear completed todos',
    ()async{
    //arrange
    when(dataBase.find(any)).
    thenAnswer((_)async => tTodos);
    //act
    var result = dataSource.clearCompleted();
    //assert
    expect(result, tTodos);
    
    },);
  });
  
}