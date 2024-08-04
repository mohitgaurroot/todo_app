import 'package:todo_app/services/database.dart';
import '../model/todo_model.dart';

class TodoRepository {
  final TodoDatabase todoDatabase = TodoDatabase.instance;

  Future<List<Todo>> getTodos() async {
    return await todoDatabase.readAllTodos();
  }

  Future<void> addTodo(Todo todo) async {
    await todoDatabase.create(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await todoDatabase.update(todo);
  }

  Future<void> deleteTodo(int id) async {
    await todoDatabase.delete(id);
  }
}
