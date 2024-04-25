// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class Todo {
  static const uuid = Uuid();

  final String id;
  String task;
  bool status;

  Todo(this.task, {this.status = false}) : id = uuid.v4();
}
