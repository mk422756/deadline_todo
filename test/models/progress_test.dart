import 'package:test/test.dart';
import 'package:deadline_todo/models/progress.dart';

void main() {
  test('Progressクラスが適切に動作する', () {
    var map = {
      "id": 1,
      "todoId": 1,
      "progress": 1,
      "date": "2020-12-15",
    };
    final progress = Progress.fromMap(map);

    expect(progress.id, 1);
    expect(progress.todoId, 1);
    expect(progress.progress, 1);
    expect(progress.date, DateTime(2020, 12, 15));

    var retMap = progress.toMap();
    expect(retMap, map);
  });
}
