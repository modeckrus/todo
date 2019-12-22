

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/feautures/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/feautures/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/feautures/todo/domain/usecases/params.dart';

class MockTodoRepository extends Mock implements TodoRepository{}

void main(){
  AddTodo usecase;
  MockTodoRepository mockTodoRepository;

  setUp((){
    mockTodoRepository = MockTodoRepository();
    usecase = AddTodo(mockTodoRepository);
  });

  final tTodo = Todo('task');

  test(
  'should add todo for concrete todo add return it if it correct',
  ()async{
  //arrange
  when(mockTodoRepository.addTodo(any)).
  thenAnswer((_)async=> Right(tTodo));
  //act
  final result = await usecase(Params(todo: tTodo));
  //assert
  expect(result, Right(tTodo));
  verify(mockTodoRepository.addTodo(tTodo));
  verifyNoMoreInteractions(mockTodoRepository);
  },);
}