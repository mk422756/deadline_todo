import 'package:test/test.dart';
import 'package:deadline_todo/models/todo.dart';

void main() {
  test('Todoクラスが適切に動作する', () {
    var map = {
      "id": 1,
      "start": "2020-12-15",
      "end": "2020-12-30",
      "title": "test"
    };
    final todo = Todo.fromMap(map);

    expect(todo.id, 1);
    expect(todo.start, DateTime(2020, 12, 15));
    expect(todo.end, DateTime(2020, 12, 30));
    expect(todo.title, "test");

    var retMap = todo.toMap();
    expect(retMap, map);
  });
}
