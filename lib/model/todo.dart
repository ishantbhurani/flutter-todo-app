import 'package:isar/isar.dart';
import 'package:todo_app/utils.dart';

part 'todo.g.dart';

@collection
class Todo {
  Id id = Isar.autoIncrement;

  String task;

  bool status;

  @enumerated
  Priority priority;

  Todo(
    this.task, {
    this.status = false,
    this.priority = Priority.low,
  });
}
