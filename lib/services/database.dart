import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/todo_model.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
      CREATE TABLE todos (
        id $idType,
        title $textType,
        isCompleted $boolType
      )
    ''');
  }

  Future<Todo> create(Todo todo) async {
    final db = await instance.database;

    final id = await db.insert('todos', todo.toMap());
    return todo.copyWith(id: id);
  }

  Future<Todo?> readTodoById(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'todos',
      columns: ['id', 'title', 'isCompleted'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Todo.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Todo>> readAllTodos() async {
    final db = await instance.database;

    const orderBy = 'id ASC';
    final result = await db.query('todos', orderBy: orderBy);

    return result.map((json) => Todo.fromMap(json)).toList();
  }

  Future<int> update(Todo todo) async {
    final db = await instance.database;

    return db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
