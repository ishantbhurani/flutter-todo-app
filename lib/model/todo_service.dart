import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/todo.dart';

class TodoService {
  static late Isar isar;
  final List<Todo> todos = [];

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TodoSchema],
      directory: dir.path,
    );
  }

  // WATCH (READ)
  Stream<List<Todo>> streamTodos =
      isar.todos.where().watch(fireImmediately: true);

  // CREATE
  Future<void> addTodo(Todo newTodo) async {
    await isar.writeTxn(() => isar.todos.put(newTodo));
  }

  // UPDATE
  Future<void> updateTodo(Todo updatedTodo) async {
    final existingNote = await isar.todos.get(updatedTodo.id);
    if (existingNote != null) {
      await isar.writeTxn(() => isar.todos.put(updatedTodo));
    }
  }

  // DELETE
  Future<void> deleteTodo(Id id) async {
    await isar.writeTxn(() => isar.todos.delete(id));
  }
}
