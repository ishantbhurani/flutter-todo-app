import 'package:flutter/material.dart';
import 'package:todo_app/components/add_todo_dialog.dart';
import 'package:todo_app/components/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todos = [
    (text: 'Task 1', status: false),
    (text: 'Task 2', status: true),
  ];

  void _updateTask(int index, ({bool status, String text}) task) {
    setState(() {
      _todos[index] = task;
    });
  }

  Future<void> _addTodo() async {
    String? text = await showDialog<String>(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );

    if (text != null && text.isNotEmpty) {
      setState(() {
        _todos.add((text: text, status: false));
      });
    }
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Todo App';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(title),
      ),
      body: TodoList(
        todos: _todos,
        onChanged: _updateTask,
        onDelete: _deleteTodo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
