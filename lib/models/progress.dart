import 'package:intl/intl.dart';

class Progress {
  int id;
  int todoId;
  int progress;
  DateTime date;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'todo_id': todoId,
      'progress': progress,
      'date': DateFormat('yyyy-MM-dd').format(date),
    };

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Progress(this.todoId, this.progress, this.date);

  Progress.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    todoId = map["todo_id"];
    progress = map["progress"];
    date = DateTime.parse(map["date"]);
  }
}
