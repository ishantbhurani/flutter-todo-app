import 'package:flutter/material.dart';
import 'package:todo_app/components/add_todo_dialog_button.dart';
import 'package:todo_app/components/add_todo_dialog_text_field.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/utils.dart';

class AddTodoDialog extends StatefulWidget {
  final Todo? todo;

  const AddTodoDialog({super.key, this.todo});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  late final TextEditingController _controller;
  late Priority _priority;

  void _updatedPriority(Priority? priority) {
    if (priority != null) {
      setState(() {
        _priority = priority;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.todo?.task);
    _priority = widget.todo?.priority ?? Priority.low;
  }

  void onSubmit() {
    Todo todo;
    if (widget.todo == null) {
      todo = Todo(_controller.text, priority: _priority);
    } else {
      todo = Todo.clone(widget.todo!);
      todo.task = _controller.text;
      todo.priority = _priority;
    }
    Navigator.pop<Todo>(context, todo);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text('${widget.todo == null ? 'Add' : 'Update'} Todo'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AddTodoDialogTextField(
            controller: _controller,
            onSubmitted: onSubmit,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Priority'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _priority,
                items: Priority.values
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: _updatedPriority,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              AddTodoDialogButton(
                text: 'Save',
                onPressed: onSubmit,
              ),
              AddTodoDialogButton(
                text: 'Cancel',
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
