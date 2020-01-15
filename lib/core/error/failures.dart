import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class Failure extends Equatable{
}
class ServerFailure extends Failure {
  final String message;
  ServerFailure({@required this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
  @override
  String toString() {
    // TODO: implement toString
    return 'Server Error: $message';
  }
}

class LocalFailure extends Failure {
  final String message;
  LocalFailure({@required this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
  @override
  String toString() {
    // TODO: implement toString
    return 'Local Error: $message';
  }
}