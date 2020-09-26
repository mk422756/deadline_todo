import 'package:intl/intl.dart';

class Todo {
  int id;
  String title;
  DateTime start;
  DateTime end;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "title": title,
      'start': DateFormat('yyyy-MM-dd').format(start),
      "end": DateFormat('yyyy-MM-dd').format(end)
    };

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Todo(this.title, this.start, this.end);

  Todo.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    start = DateTime.parse(map["start"]);
    end = DateTime.parse(map["end"]);
  }

  String toString() {
    return 'id $id, title $title, start ${DateFormat('yyyy-MM-dd').format(start)}, end ${DateFormat('yyyy-MM-dd').format(end)}';
  }

  bool isFinish() {
    return this.end.isBefore(DateTime.now());
  }
}
