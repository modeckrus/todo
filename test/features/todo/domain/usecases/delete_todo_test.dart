import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/feautures/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/feautures/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/feautures/todo/domain/usecases/delete_todo.dart';
import 'package:todoapp/feautures/todo/domain/usecases/params.dart';

class MockTodoRepository extends Mock implements TodoRepository{}

void main(){
  DeleteTodo usecase;
  MockTodoRepository mockTodoRepository;

  setUp((){
    mockTodoRepository = MockTodoRepository();
    usecase = DeleteTodo(mockTodoRepository);
  });

  final tTodo = Todo('task');
  final List<Todo> tListTodos = [tTodo, tTodo];

  test(
  'should add todo for concrete todo add return it if it correct',
  ()async{
  //arrange
  when(mockTodoRepository.deleteTodo(any)).
  thenAnswer((_)async=> Right(tListTodos));
  //act
  final result = await usecase(Params(todo: tTodo));
  //assert
  expect(result, Right(tListTodos));
  verify(mockTodoRepository.deleteTodo(tTodo));
  verifyNoMoreInteractions(mockTodoRepository);
  },);
}