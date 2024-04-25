import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/add_todo_dialog.dart';
import 'package:todo_app/components/todo_list.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todos = initialTodos;

  Filter _filter = Filter.all;

  void _updateFilter(Filter filter) {
    setState(() {
      _filter = filter;
    });
  }

  void _updateTask(Todo updatedTodo) {
    for (final todo in _todos) {
      if (todo.id == updatedTodo.id) {
        setState(() {
          todo.task = updatedTodo.task;
          todo.status = updatedTodo.status;
        });
        break;
      }
    }
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

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.removeWhere((t) => t.id == todo.id);
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
          PopupMenuButton(
            icon: const Icon(Icons.filter_list),
            onSelected: _updateFilter,
            itemBuilder: (context) => Filter.values
                .map(
                  (filter) => PopupMenuItem(
                    value: filter,
                    child: Text(filter.name.toUpperCase()),
                  ),
                )
                .toList(),
          ),
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
        filter: _filter,
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
