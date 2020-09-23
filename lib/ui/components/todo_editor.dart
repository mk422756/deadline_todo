import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/providers/todo_provider.dart';
import 'package:deadline_todo/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoEditor extends StatefulWidget {
  final Todo todo;

  TodoEditor({this.todo});

  @override
  _TodoEditorState createState() => _TodoEditorState();
}

class _TodoEditorState extends State<TodoEditor> {
  TextEditingController _textController;
  String _title = "";
  DateTime _startDate = new DateTime.now();
  DateTime _endDate = new DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      _title = widget.todo.title;
      _textController = TextEditingController(text: _title);
      _startDate = widget.todo.start;
      _endDate = widget.todo.end;
    }
  }

  void _handleTitle(String e) {
    setState(() {
      _title = e;
    });
  }

  Future<DateTime> _selectDate(
      BuildContext context, DateTime initialDate) async {
    DateTime date = new DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now().add(new Duration(days: 360)));
    if (picked != null) {
      date = picked;
    }

    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          child: Text(DateFormat('yyyy-MM-dd').format(_startDate) + " から"),
          color: Colors.orange,
          textColor: Colors.white,
          onPressed: () async {
            var date = await _selectDate(context, _startDate);
            setState(() {
              _startDate = date;
            });
          },
        ),
        RaisedButton(
          child: Text(DateFormat('yyyy-MM-dd').format(_endDate) + " までに"),
          color: Colors.orange,
          textColor: Colors.white,
          onPressed: () async {
            var date = await _selectDate(context, _endDate);
            setState(() {
              _endDate = date;
            });
          },
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: new TextField(
            enabled: true,
            maxLength: 20,
            maxLengthEnforced: false,
            style: TextStyle(color: Colors.blue),
            obscureText: false,
            maxLines: 1,
            onChanged: _handleTitle,
            controller: _textController,
          ),
        ),
        RaisedButton(
          child: Text("OK!!"),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () async {
            TodoProvider provider = TodoProvider(DBHelper());

            Todo todo;
            if (widget.todo == null) {
              todo = Todo(_title, _startDate, _endDate);
              await provider.insert(todo);
            } else {
              todo = widget.todo;
              todo.title = _title;
              todo.start = _startDate;
              todo.end = _endDate;
              await provider.update(todo);
            }

            Navigator.pop(context, todo);
          },
        ),
      ],
    );
  }
}
