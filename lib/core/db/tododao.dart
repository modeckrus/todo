import 'package:sembast/sembast.dart';
import 'package:todoapp/feautures/todo/data/models/todo_model.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

import 'mydatabase.dart';

abstract class TodoDao{
  Future<int> add(Todo todo);
  Future<List<int>> addAll(List<Todo> values);
  Future<List<Todo>> find(Finder finder);
  Future<void> delete(Todo todo);
  Future<void> deleteAll(List<Todo> todos);
}
class TodoDaoImplement extends TodoDao{
  final Database database;
  var store = intMapStoreFactory.store('todos');
  Future<Database> get _db async => await AppDatabase.instance.database;
  TodoDaoImplement(this.database);

  @override
  Future<int> add(Todo todo) async{
    return await store.add(await _db, TodoModel.fromTodo(todo).toJson());
  }

  @override
  Future<List<int>> addAll(List<Todo> values) async{
    List<Map<String, dynamic>> list;
    values.forEach((f){
      list.add(TodoModel.fromTodo(f).toJson());
    });
    return await store.addAll(await _db, list);
  }

  @override
  Future<List<Todo>> find(Finder finder) async{
    List<Todo> list;
    var snapshots = await store.find(await _db, finder: finder);
    snapshots.forEach((f){
      list.add(TodoModel.fromJson(f.value));
    });
    return list;
  }

  @override
  Future<void> delete(Todo todo) async{
    Finder finder = Finder(filter: Filter.byKey(todo.id));
    store.delete(await _db, finder: finder);
  }

  @override
  Future<void> deleteAll(List<Todo> todos) async{
  todos.forEach((f)async{
    store.delete(await _db, finder: Finder(filter: Filter.byKey(f.id)));
  });
  }

  

  

  

}