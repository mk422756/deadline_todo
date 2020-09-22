import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> getDb() async {
    return await openDatabase('my_db.db10', version: 1, onCreate: _onCreate);
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
      date TEXT,
      progress INTEGER,
    FOREIGN KEY(todo_id) references todos(id)
    FOREIGN KEY(progress) references progress_levels(id)
    UNIQUE(todo_id, date));
    ''');

    await db.execute('''
    CREATE TABLE progress_levels (
      id INTEGER PRIMARY KEY, 
      level TEXT);
    ''');

    await db.execute(
        'INSERT INTO progress_levels(id, level) VALUES (1, "very good");');
    await db
        .execute('INSERT INTO progress_levels(id, level) VALUES (2, "good");');
    await db
        .execute('INSERT INTO progress_levels(id, level) VALUES (3, "so-so");');
    await db.execute(
        'INSERT INTO progress_levels(id, level) VALUES (4, "not good");');
  }
}
