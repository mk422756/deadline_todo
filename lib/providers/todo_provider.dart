import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/utils/db_helper.dart';

class TodoProvider {
  final DBHelper dbHelper;

  static final tableTodo = "todos";
  static final columnId = "id";
  static final columnStart = "start";
  static final columnEnd = "end";
  static final columnTitle = "title";

  TodoProvider(this.dbHelper);

  Future<Todo> insert(Todo todo) async {
    var db = await dbHelper.getDb();
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<Todo> getTodo(int id) async {
    var db = await dbHelper.getDb();
    List<Map> maps =
        await db.query(tableTodo, where: '$columnId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Todo>> getAll() async {
    var db = await dbHelper.getDb();
    List<Map> maps = await db.query(tableTodo);

    return maps.map((map) => Todo.fromMap(map)).toList();
  }

  Future<List<Todo>> getByNotHasTodayProgress() async {
    var db = await dbHelper.getDb();
    List<Map> maps = await db.rawQuery('SELECT * FROM $tableTodo');

    return maps.map((map) => Todo.fromMap(map)).toList();
  }

  Future<int> delete(int id) async {
    var db = await dbHelper.getDb();
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    var db = await dbHelper.getDb();
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }
}
