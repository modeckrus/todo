import 'package:sembast/sembast.dart';
import 'package:todoapp/core/db/mydatabase.dart';
import 'package:todoapp/core/db/tododao.dart';
import 'package:todoapp/feautures/todo/data/models/todo_model.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

abstract class TodoLocalDataSource {

  Future<void> addTodo(Todo todo);
  Future<List<Todo>> clearCompleted();
  Future<List<Todo>> deleteTodo(Todo todo);
  Future<List<Todo>> loadTodos();
  Future<List<Todo>> toggleAll();
  Future<Todo> updateTodo(Todo todo);
}
class TodoLocalDataSourceImpl extends TodoLocalDataSource{
  final TodoDaoImplement database;
  TodoLocalDataSourceImpl(this.database);
  @override
  Future<void> addTodo(Todo todo) async{
    database.add(todo);
      
  }

  @override
  Future<List<Todo>> clearCompleted() async{
    var records = await database.find(Finder(filter: Filter.equal('complete', true)));
    await database.database.deleteAll(records);
    
    return await this.loadTodos();
  }

  @override
  Future<List<Todo>> deleteTodo(Todo todo) async{
    database.delete(todo);
  }

  @override
  Future<List<Todo>> loadTodos() {
    return database.find(Finder());
  }

  @override
  Future<List<Todo>> toggleAll() async{
    var records = await database.find(Finder(filter: Filter.equal('complete', false)));
    List<Todo> list;
    records.forEach((stodo){
      Todo todo = Todo(stodo.task, id: stodo.id, complete: true, note: stodo.note);
      list.add(todo);
    });
    await database.deleteAll(records);
    await database.addAll(list);
    return list;
  }

  @override
  Future<Todo> updateTodo(Todo todo) {
    database.database.update(todo, todo.id);
  }

}