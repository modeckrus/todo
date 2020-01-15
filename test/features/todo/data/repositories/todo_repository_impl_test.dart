import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:todoapp/core/network/network_info.dart';
import 'package:todoapp/feautures/todo/data/datasources/todo_http_data_source.dart';
import 'package:todoapp/feautures/todo/data/datasources/todo_local_data_source.dart';
import 'package:todoapp/feautures/todo/data/models/todo_model.dart';
import 'package:todoapp/feautures/todo/data/respositories/todo_repository_impl.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

import '../../fixtures/fixture.dart';

class MockHttpDataSource extends Mock implements TodoHttpDataSourceImpl{}
class MockLocalDataSource extends Mock implements TodoLocalDataSourceImpl{}
class MockNetworkInfo extends Mock implements NetworkInfo{}

void main(){
  TodoRepositoryImpl repository;
  MockHttpDataSource mockHttpDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockHttpDataSource = MockHttpDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TodoRepositoryImpl(
      http: mockHttpDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body){
    group('devise is online', (){
      setUp((){
        when(mockNetworkInfo.isConnected).thenAnswer((_)async => true);
      });
      body();
    });
  }
  void runTestsOffline(Function body){
    group('devise is offline', (){
      setUp((){
        when(mockNetworkInfo.isConnected).thenAnswer((_)async => false);
      });
      body();
    });
  }
  group('addTodo', (){
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    final tTodos = [tTodoModel];

    test(
    'should check if the device is online',
    ()async{
    //arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_)async => true);

    //act
    repository.addTodo(tTodo);
    //assert
    verify(mockNetworkInfo.isConnected);
    },);
    runTestsOnline((){
      test(
      'should return remote data when the call to remote data source is success',
      ()async{
      //arrange
      when(mockHttpDataSource.addTodo(any)).
      thenAnswer((_)async => tTodoModel);
      //act
      final result = await repository.addTodo(tTodo);
      //assert
      verify(mockHttpDataSource.addTodo(tTodo));
      //expect(result, equals(Right(tTodo)));
      },);
    });
  });
}