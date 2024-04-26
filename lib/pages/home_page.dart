import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/add_todo_dialog.dart';
import 'package:todo_app/components/todo_list.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/model/todo_service.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoService = TodoService();

  Filter _filter = Filter.all;

  void _updateFilter(Filter filter) {
    setState(() {
      _filter = filter;
    });
  }

  void _updateTask(Todo updatedTodo) {
    todoService.updateTodo(updatedTodo);
  }

  Future<void> _addTodo() async {
    Todo? todo = await showDialog<Todo>(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );

    if (todo != null && todo.task.isNotEmpty) {
      todoService.addTodo(todo);
    }
  }

  void _deleteTodo(int id) {
    todoService.deleteTodo(id);
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
      body: StreamBuilder(
        stream: todoService.streamTodos,
        builder: (context, snapshot) {
          List<Todo> todos = [];
          if (snapshot.hasData) {
            todos = snapshot.data!;
          }
          return TodoList(
            todos: todos,
            filter: _filter,
            onChanged: _updateTask,
            onDelete: _deleteTodo,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
