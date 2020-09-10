import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> getDb() async {
    return await openDatabase('my_db.db', version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todos (id INTEGER PRIMARY KEY AUTOINCREMENT, start TEXT, end TEXT, title TEXT);
    ''');

    await db.execute('''
    INSERT INTO todos(start, end, title) VALUES (date('2020-12-15'), date('2020-12-30'), "test3");
    ''');

    var ret = await db.rawQuery('SELECT * FROM todos');
    print(ret);
  }
}
