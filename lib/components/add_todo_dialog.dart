import 'package:flutter/material.dart';
import 'package:todo_app/components/add_todo_dialog_button.dart';
import 'package:todo_app/components/add_todo_dialog_text_field.dart';

class AddTodoDialog extends StatelessWidget {
  final String? text;

  const AddTodoDialog({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: text);

    void onSubmit() {
      Navigator.pop(context, controller.text);
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('Add Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AddTodoDialogTextField(
            controller: controller,
            onSubmitted: onSubmit,
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
