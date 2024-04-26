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

  Todo.clone(Todo t)
      : id = t.id,
        task = t.task,
        status = t.status,
        priority = t.priority;

  @override
  String toString() {
    return 'Todo(id: $id, task: $task, status: $status, priority: $priority)';
  }
}
