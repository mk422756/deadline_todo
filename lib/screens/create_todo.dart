import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTodo extends StatefulWidget {
  static final route = "/create_todo";
  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  DateTime _startDate = new DateTime.now();
  DateTime _endDate = new DateTime.now();
  String _title = '';

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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
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
                // 入力数
                maxLength: 20,
                maxLengthEnforced: false,
                style: TextStyle(color: Colors.blue),
                obscureText: false,
                maxLines: 1,
                //パスワード
                onChanged: _handleTitle,
              ),
            ),
            RaisedButton(
              child: Text("OK!!"),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () async {
                Todo todo = Todo(_title, _startDate, _endDate);
                TodoProvider provider = TodoProvider();
                await provider.insert(todo);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
