import 'package:deadline_todo/models/progress.dart';
import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/utils/db_helper.dart';

class ProgressProvider {
  DBHelper dbHelper = DBHelper();

  static final tableProgress = "progresses";
  static final columnId = "id";
  static final columnTodoId = "todo_id";
  static final columnProgress = "progress";
  static final columnDate = "date";

  Future<Progress> insert(Progress progress) async {
    var db = await dbHelper.getDb();
    progress.id = await db.insert(tableProgress, progress.toMap());
    return progress;
  }

  Future<Progress> get(int id) async {
    var db = await dbHelper.getDb();
    List<Map> maps =
        await db.query(tableProgress, where: '$columnId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Progress.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Progress>> getAll() async {
    var db = await dbHelper.getDb();
    List<Map> maps = await db.query(tableProgress);

    return maps.map((map) => Progress.fromMap(map)).toList();
  }

  Future<int> delete(int id) async {
    var db = await dbHelper.getDb();
    return await db
        .delete(tableProgress, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Progress progress) async {
    var db = await dbHelper.getDb();
    return await db.update(tableProgress, progress.toMap(),
        where: '$columnId = ?', whereArgs: [progress.id]);
  }
}