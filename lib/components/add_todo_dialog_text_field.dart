import 'package:flutter/material.dart';

class AddTodoDialogTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onSubmitted;

  const AddTodoDialogTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Buy groceries...',
      ),
      onSubmitted: (_) => onSubmitted(),
    );
  }
}
