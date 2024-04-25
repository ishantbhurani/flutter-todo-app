import 'package:todo_app/utils.dart';
import 'package:uuid/uuid.dart';

class Todo {
  static const uuid = Uuid();

  final String id;
  String task;
  bool status;
  Priority priority;

  Todo(
    this.task, {
    this.status = false,
    this.priority = Priority.low,
  }) : id = uuid.v4();
}
