import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/feautures/todo/data/models/todo_model.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

import '../../fixtures/fixture.dart';

void main() {
  final todomodel = TodoModel('task', id: '1', note: 'note', complete: false);

  test(
  'should should be a subclass of Todo entity',
  ()async{
  //arrange
  
  //act
  
  //assert
  expect(todomodel, isA<Todo>());
  },);

  group('from Json', (){
    test(
    'should return a valid model when JSON is valid',
    ()async{
    //arrange
    final Map<String, dynamic> jsonMap = 
      json.decode(fixture('todo.json'));
    //act
    final result = TodoModel.fromJson(jsonMap);
    //assert
    expect(result, todomodel);
    },);
  });
}