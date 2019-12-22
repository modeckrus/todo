import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/feautures/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/feautures/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/feautures/todo/domain/usecases/load_todos.dart';
import 'package:todoapp/feautures/todo/domain/usecases/params.dart';

class MockTodoRepository extends Mock implements TodoRepository{}

void main(){
  LoadTodos usecase;
  MockTodoRepository mockTodoRepository;

  setUp((){
    mockTodoRepository = MockTodoRepository();
    usecase = LoadTodos(mockTodoRepository);
  });

  final tTodo = Todo('task');
  final List<Todo> tListTodos = [tTodo, tTodo];

  test(
  'should add todo for concrete todo add return it if it correct',
  ()async{
  //arrange
  when(mockTodoRepository.loadTodos()).
  thenAnswer((_)async=> Right(tListTodos));
  //act
  final result = await usecase(NoParams());
  //assert
  expect(result, Right(tListTodos));
  verify(mockTodoRepository.loadTodos());
  verifyNoMoreInteractions(mockTodoRepository);
  },);
}