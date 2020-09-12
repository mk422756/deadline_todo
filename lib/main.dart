import 'package:deadline_todo/ui/screens/create_todo.dart';
import 'package:deadline_todo/ui/screens/todo_detail.dart';
import 'package:deadline_todo/ui/screens/top_page.dart';
import 'package:deadline_todo/ui/screens/update_todo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deadline TODO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: TopPage.route,
      routes: <String, WidgetBuilder>{
        TopPage.route: (BuildContext context) => TopPage(),
        CreateTodo.route: (BuildContext context) => CreateTodo(),
        UpdateTodo.route: (BuildContext context) => UpdateTodo(),
        TodoDetail.route: (BuildContext context) => TodoDetail(),
      },
    );
  }
}
