import 'dart:ui';

import 'package:flutter/material.dart';
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

enum Priority {
  low,
  medium,
  high;
}

Color getPriorityColor(Priority priority) => switch (priority) {
      Priority.high => Colors.red,
      Priority.medium => Colors.yellow,
      _ => Colors.green,
    };
