import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import '../model/todo.dart';

class ToDoDatabase {
  static Future<sql.Database> database() async {
    final database = sql.openDatabase(
      path.join(await sql.getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id TEXT PRIMARY KEY, title TEXT, description TEXT, isDone INTEGER)',
        );
      },
      version: 1,
    );

    return database;
  }

  static Future create(ToDo todo) async {
    final db = await ToDoDatabase.database();

    await db.insert(
      'todos',
      todo.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future update(ToDo toDo) async {
    final db = await ToDoDatabase.database();

    await db
        .update('todos', toDo.toJson(), where: 'id = ?', whereArgs: [toDo.id]);
  }

  static Future delete(String id) async {
    final db = await ToDoDatabase.database();

    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<ToDo>> getAll() async {
    final db = await ToDoDatabase.database();

    final result = await db.query('todos');

    final List<ToDo> toDoList = result.map((e) => ToDo.fromJson(e)).toList();

    return toDoList;
  }
}
