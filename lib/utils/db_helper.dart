import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> getDb() async {
    return await openDatabase('my_db.db', version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    start TEXT,
    end TEXT,
    title TEXT);
    ''');

    await db.execute('''
    CREATE TABLE progresses (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    todo_id INTEGER,
    date, TEXT,
    progress, INTEGER,
    foreign key(todo_id) references todos(id));
    ''');
  }
}
