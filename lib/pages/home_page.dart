import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/add_todo_dialog.dart';
import 'package:todo_app/components/todo_list.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/providers/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todos = [
    Todo('Task 1'),
    Todo('Task 2', status: true),
  ];

  void _updateTask(int index, Todo task) {
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
        _todos.add(Todo(text));
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(title),
        actions: [
          IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: themeProvider.isDarkMode()
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
            tooltip: 'Toggle theme',
          )
        ],
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
