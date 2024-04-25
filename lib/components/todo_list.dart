import 'package:flutter/material.dart';
import 'package:todo_app/components/add_todo_dialog.dart';
import 'package:todo_app/model/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final void Function(int, Todo) onChanged;
  final void Function(int) onDelete;

  const TodoList({
    super.key,
    required this.todos,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> onPressed(int index, ({bool status, String text}) task) async {
      String? text = await showDialog<String>(
        context: context,
        builder: (context) => AddTodoDialog(text: task.text),
      );

      if (text != null && text.isNotEmpty) {
        final newTask = Todo(text, status: task.status);

        onChanged(index, newTask);
      }
    }

    return Center(
      child: SizedBox(
        width: 800,
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];

            return CheckboxListTile(
              value: todo.status,
              onChanged: (status) {
                if (status != null) {
                  todo.status = status;
                  onChanged(index, todo);
                }
              },
              title: Text(
                todo.task,
                style: TextStyle(
                  decoration: todo.status
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              secondary: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => onPressed(
                          index, (text: todo.task, status: todo.status)),
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () => onDelete(index),
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
