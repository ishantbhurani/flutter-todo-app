import 'package:flutter/material.dart';
import 'package:todo_app/components/add_todo_dialog.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/utils.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Filter filter;
  final void Function(Todo) onChanged;
  final void Function(int) onDelete;

  const TodoList({
    super.key,
    required this.todos,
    required this.filter,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final filteredTodos = switch (filter) {
      Filter.pending => todos.where((todo) => !todo.status).toList(),
      Filter.completed => todos.where((todo) => todo.status).toList(),
      _ => todos,
    };

    Future<void> onPressed(Todo todo) async {
      Todo? updatedTodo = await showDialog<Todo>(
        context: context,
        builder: (context) => AddTodoDialog(todo: todo),
      );

      if (updatedTodo != null && updatedTodo.task.isNotEmpty) {
        onChanged(updatedTodo);
      }
    }

    return Center(
      child: filteredTodos.isEmpty
          ? const Text(
              'Nothing here yet! 🎯',
              style: TextStyle(fontSize: 20),
            )
          : SizedBox(
              width: 800,
              child: ListView.builder(
                itemCount: filteredTodos.length,
                itemBuilder: (context, index) {
                  final todo = filteredTodos[index];

                  return CheckboxListTile(
                    value: todo.status,
                    onChanged: (status) {
                      if (status != null) {
                        todo.status = status;
                        onChanged(todo);
                      }
                    },
                    title: Row(
                      children: [
                        Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            color: getPriorityColor(todo.priority),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Flexible(
                          child: Text(
                            todo.task,
                            style: TextStyle(
                              decoration: todo.status
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () => onPressed(todo),
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () => onDelete(todo.id),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
