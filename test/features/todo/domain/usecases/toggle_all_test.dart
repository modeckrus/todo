import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';
import 'package:todoapp/feautures/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/feautures/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/feautures/todo/domain/usecases/load_todos.dart';
import 'package:todoapp/feautures/todo/domain/usecases/params.dart';
import 'package:todoapp/feautures/todo/domain/usecases/toggle_all.dart';

class MockTodoRepository extends Mock implements TodoRepository{}

void main(){
  ToggleAll usecase;
  MockTodoRepository mockTodoRepository;

  setUp((){
    mockTodoRepository = MockTodoRepository();
    usecase = ToggleAll(mockTodoRepository);
  });

  final tTodo = Todo('task');
  final List<Todo> tListTodos = [tTodo, tTodo];

  test(
  'should toggle all todos add return it if it correct',
  ()async{
  //arrange
  when(mockTodoRepository.toggleAll()).
  thenAnswer((_)async=> Right(tListTodos));
  //act
  final result = await usecase(NoParams());
  //assert
  expect(result, Right(tListTodos));
  verify(mockTodoRepository.toggleAll());
  verifyNoMoreInteractions(mockTodoRepository);
  },);
}