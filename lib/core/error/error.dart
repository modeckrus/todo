import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MyError extends Equatable{
  final String message;
  const MyError({
    @required this.message
  });

  @override
  // TODO: implement props
  List<Object> get props => [message];
}