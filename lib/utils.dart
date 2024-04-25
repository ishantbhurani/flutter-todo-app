import 'package:todo_app/model/todo.dart';

final initialTodos = [
  Todo('Task 1'),
  Todo('Task 2', status: true),
];

enum Filter {
  all,
  pending,
  completed,
}
