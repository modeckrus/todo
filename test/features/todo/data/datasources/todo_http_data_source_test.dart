import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:todoapp/core/httpclient/httpclient.dart';
import 'package:todoapp/feautures/todo/data/datasources/todo_http_data_source.dart';
import 'package:todoapp/feautures/todo/data/models/todo_model.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/core/error/exception.dart';

import '../../fixtures/fixture.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  TodoHttpDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TodoHttpDataSourceImpl(client: mockHttpClient);
  });
  void setUpMock(){
    when(mockHttpClient.setCookie(any, any)).thenReturn((){
      mockHttpClient.head['Content-Type'] = 'application/json';
    });
  }
  void setUpMockHttpClientSuccess200forsingle() {
    setUpMock();
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('todo.json'), 200));
  }

  void setUpMockHttpClientSuccess200formultiple() {
    setUpMock();
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('todos.json'), 200));
  }

  void setUpMockHttpPostSuccesforSingle() {
    setUpMock();
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(fixture('todo.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    setUpMock();
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }
  void setUpMockHttpPostSuccesforMultiple(){
    setUpMock();
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(fixture('todos.json'), 200));
  }

  void setUpMockHttpPostFailure() {
    setUpMock();
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }
  

  group('addTodo', () {
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    test(
      '''should perform a POST request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpPostSuccesforSingle();
        // act
        dataSource.addTodo(tTodo);
        // assert
        verify(mockHttpClient.post(
          'http://localhost:8080/api/loadtodos',
          body: tTodoModel.toJson(),
        ));
      },
    );

    test(
      'should return Todo when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpPostSuccesforSingle();
        // act
        final result = await dataSource.addTodo(tTodo);
        // assert
        expect(result, equals(tTodoModel));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpPostFailure();
        // act
        final call = dataSource.addTodo(tTodo);
        // assert
        expect(() => call, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('clearCompleted', () {
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
        ));
      },
    );

    test(
      'should return List<Todo> when the response code is 200 (success)',
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

  group('deleteTodo', () {
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    final tTodos = [tTodoModel];
    test(
      '''should perform a POST request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpPostSuccesforMultiple();
        // act
        dataSource.deleteTodo(tTodo);
        // assert
        verify(mockHttpClient.post(
          'http://localhost:8080/api/deletetodo',
          body: tTodoModel.toJson(), 
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpPostSuccesforMultiple();
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
        setUpMockHttpPostFailure();
        // act
        final call = dataSource.deleteTodo(tTodo);
        // assert
        expect(() => call, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('loadTodos', () {
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

  group('toggleAll', () {
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

  group('updateTodo', () {
    final tTodo = Todo('task', complete: false, id: '1', note: 'note');
    final tTodoModel = TodoModel.fromJson(json.decode(fixture('todo.json')));
    final tTodos = [tTodoModel];
    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpPostSuccesforSingle();
        // act
        dataSource.updateTodo(tTodo);
        // assert
        verify(mockHttpClient.post(
          'http://localhost:8080/api/updatetodo',
          body: tTodoModel.toJson(),
        ));
      },
    );

    test(
      'should return updated todo when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpPostSuccesforSingle();
        // act
        final result = await dataSource.updateTodo(tTodo);
        // assert
        expect(result, equals(tTodoModel));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpPostFailure();
        // act
        final call = dataSource.updateTodo(tTodo);
        // assert
        expect(() => call, throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
