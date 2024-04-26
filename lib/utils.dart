import 'package:flutter/material.dart';

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
