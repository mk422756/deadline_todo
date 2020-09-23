import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/providers/todo_provider.dart';
import 'package:deadline_todo/utils/db_helper_mock.dart';
import 'package:test/test.dart';

void main() {
  test('TodoProvider', () async {
    TodoProvider provider = TodoProvider(DBHelperMock());
    Todo todo = await provider.getTodo(1);
    expect(todo.title, "test title");
  });
}
