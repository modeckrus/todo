import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;
  Todo(
    this.task, {
    this.complete = false,
    this.id,
    this.note = '',
  });

  @override
  List<Object> get props => [complete, id, note, task];

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
  }
}
