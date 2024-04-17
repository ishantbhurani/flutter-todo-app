import 'package:flutter/material.dart';
import 'package:todo_app/components/add_todo_dialog.dart';

class TodoList extends StatelessWidget {
  final List<({bool status, String text})> todos;
  final void Function(int, ({bool status, String text})) onChanged;
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
        final newTask = (text: text, status: task.status);

        onChanged(index, newTask);
      }
    }

    return Center(
      child: SizedBox(
        width: 800,
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final (:status, :text) = todos[index];

            return CheckboxListTile(
              value: status,
              onChanged: (status) =>
                  onChanged(index, (text: text, status: status ?? false)),
              title: Text(
                text,
                style: TextStyle(
                  decoration:
                      status ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              secondary: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () =>
                          onPressed(index, (text: text, status: status)),
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
