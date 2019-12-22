import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/feautures/todo/domain/entities/todo.dart';

class Params extends Equatable{
  final Todo todo;
  Params({
    @required this.todo,
  });


  @override
  // TODO: implement props
  List<Object> get props => [todo];
  }