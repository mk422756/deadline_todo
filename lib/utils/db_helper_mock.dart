import 'package:deadline_todo/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBHelperMock implements DBHelper {
  Future<Database> getDb() async {
    try {
      OpenDatabaseOptions options =
          OpenDatabaseOptions(onCreate: _onCreate, version: 1);
      return await databaseFactoryFfi.openDatabase(inMemoryDatabasePath,
          options: options);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _onCreate(Database db, int version) async {
    await initDB(db);
  }
}
