import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/providers/todo_provider.dart';
import 'package:flutter/material.dart';

class TodoDetail extends StatelessWidget {
  static final route = "/todo_detail";

  Future<int> deleteTodo(Todo todo) {
    TodoProvider provider = TodoProvider();
    return provider.delete(todo.id);
  }

  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(todo.start.toString() + ' から'),
            Text(todo.end.toString() + ' までに'),
            Text(todo.title),
            RaisedButton(
              child: Text("削除"),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () async {
                await deleteTodo(todo);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
