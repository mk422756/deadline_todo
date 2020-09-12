import 'package:deadline_todo/ui/components/todo_editor.dart';
import 'package:flutter/material.dart';

class CreateTodo extends StatelessWidget {
  static final route = "/create_todo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TodoEditor(
          "",
          DateTime.now(),
          DateTime.now(),
        ),
      ),
    );
  }
}
