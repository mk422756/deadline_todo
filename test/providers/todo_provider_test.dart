import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/providers/todo_provider.dart';
import 'package:deadline_todo/utils/db_helper_mock.dart';
import 'package:test/test.dart';
import 'package:intl/intl.dart';

void main() {
  test('TodoProvider', () async {
    var helper = DBHelperMock();
    var db = await helper.getDb();
    await db.execute(
        'INSERT INTO todos(start, end, title) VALUES (date("2020-01-01"),date("2020-12-01"), "test title1");');
    await db.execute(
        'INSERT INTO todos(start, end, title) VALUES (date("2020-01-01"),date("2020-12-01"), "test title2");');
    await db.execute(
        'INSERT INTO todos(start, end, title) VALUES (date("2020-01-01"),date("2020-12-01"), "test title3");');
    TodoProvider provider = TodoProvider(helper);

    Todo todo1 = await provider.getTodo(1);
    expect(todo1.title, "test title1");
    Todo todo2 = await provider.getTodo(2);
    expect(todo2.title, "test title2");
    Todo todo3 = await provider.getTodo(3);
    expect(todo3.title, "test title3");

    List<Todo> todos = await provider.getAll();
    expect(todos.length, 3);

    db.close();
  });

  test('TodoProviderの今日の進捗が入力されていないTODOを探す', () async {
    var helper = DBHelperMock();
    var db = await helper.getDb();
    await db.execute(
        'INSERT INTO todos(start, end, title) VALUES (date("2020-01-01"),date("2020-12-01"), "test title1");');
    await db.execute(
        'INSERT INTO todos(start, end, title) VALUES (date("2020-01-01"),date("2020-12-01"), "test title2");');

    var today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var yesterday = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 1)));
    await db.execute(
        'INSERT INTO progresses(todo_id, date, progress) VALUES (1,date("$today"),1);');
    await db.execute(
        'INSERT INTO progresses(todo_id, date, progress) VALUES (1,date("$yesterday"),1);');

    TodoProvider provider = TodoProvider(helper);

    List<Todo> todos = await provider.getByNotHasTodayProgress();
    expect(todos.length, 1);
    expect(todos[0].title, "test title2");

    db.close();
  });
}
