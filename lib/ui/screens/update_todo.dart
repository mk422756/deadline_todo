import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/ui/components/todo_editor.dart';
import 'package:flutter/material.dart';

class UpdateTodo extends StatelessWidget {
  static final route = "/update_todo";

  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TodoEditor(todo: todo),
      ),
    );
  }
}
