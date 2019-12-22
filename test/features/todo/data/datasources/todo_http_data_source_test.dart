import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:todoapp/feautures/todo/data/datasources/todo_http_data_source.dart';
import 'package:todoapp/feautures/todo/data/models/todo_model.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/core/error/exception.dart';

import '../../fixtures/fixture.dart';
class MockHttpClient extends Mock implements http.Client{}


void main(){
  TodoHttpDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient = MockHttpClient();
    dataSource = TodoHttpDataSourceImpl(client: mockHttpClient);
  });
  void setUpMockHttpClientSuccess200forsingle() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('todo.json'), 200));
  }
  void setUpMockHttpClientSuccess200formultiple() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('todos.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }
  group('addTodo', (){
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200formultiple();
        // act
        dataSource.loadTodos();
        // assert
        verify(mockHttpClient.get(
          'http://localhost:8080/api/loadTodos',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200formultiple();
        // act
        final result = await dataSource.loadTodos();
        // assert
        expect(result, equals(tTodoModel));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.loadTodos();
        // assert
        expect(() => call, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('clearCompleted', (){
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    final tTodos = [tTodoModel];
    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200formultiple();
        // act
        dataSource.clearCompleted();
        // assert
        verify(mockHttpClient.get(
          'http://localhost:8080/api/clearcompleted',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200formultiple();
        // act
        final result = await dataSource.clearCompleted();
        // assert
        expect(result, equals(tTodos));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.clearCompleted();
        // assert
        expect(() => call, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('deleteTodo', (){
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    final tTodos = [tTodoModel];
    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200formultiple();
        // act
        dataSource.deleteTodo(tTodo);
        // assert
        verify(mockHttpClient.get(
          'http://localhost:8080/api/deletetodo',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200formultiple();
        // act
        final result = await dataSource.deleteTodo(tTodo);
        // assert
        expect(result, equals(tTodos));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.deleteTodo(tTodo);
        // assert
        expect(() => call, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('loadTodos', (){
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    final tTodos = [tTodoModel];
    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200formultiple();
        // act
        dataSource.loadTodos();
        // assert
        verify(mockHttpClient.get(
          'http://localhost:8080/api/loadtodos',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200formultiple();
        // act
        final result = await dataSource.loadTodos();
        // assert
        expect(result, equals(tTodos));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.loadTodos();
        // assert
        expect(() => call, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('toggleAll', (){
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    final tTodos = [tTodoModel];
    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200formultiple();
        // act
        dataSource.toggleAll();
        // assert
        verify(mockHttpClient.get(
          'http://localhost:8080/api/toggleAll',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200formultiple();
        // act
        final result = await dataSource.toggleAll();
        // assert
        expect(result, equals(tTodos));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.toggleAll();
        // assert
        expect(() => call, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('updateTodo', (){
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    final tTodos = [tTodoModel];
    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200forsingle();
        // act
        dataSource.updateTodo(tTodo);
        // assert
        verify(mockHttpClient.get(
          'http://localhost:8080/api/updatetodo',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200forsingle();
        // act
        final result = await dataSource.updateTodo(tTodo);
        // assert
        expect(result, equals(tTodos));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.updateTodo(tTodo);
        // assert
        expect(() => call, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}