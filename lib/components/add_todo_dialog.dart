import 'package:flutter/material.dart';
import 'package:todo_app/components/add_todo_dialog_button.dart';
import 'package:todo_app/components/add_todo_dialog_text_field.dart';
import 'package:todo_app/utils.dart';

class AddTodoDialog extends StatefulWidget {
  final String? text;

  const AddTodoDialog({super.key, this.text});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  Priority _priority = Priority.low;

  void _updatedPriority(Priority? priority) {
    if (priority != null) {
      setState(() {
        _priority = priority;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: widget.text);

    void onSubmit() {
      Navigator.pop(context, controller.text);
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text('${widget.text == null ? 'Add' : 'Update'} Todo'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AddTodoDialogTextField(
            controller: controller,
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
