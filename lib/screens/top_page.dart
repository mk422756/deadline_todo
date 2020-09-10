import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/providers/todo_provider.dart';
import 'package:deadline_todo/screens/create_todo.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  static final route = "/";
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Future<List<Todo>> getTodos() {
    TodoProvider provider = TodoProvider();
    return provider.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getTodos(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          List<Todo> todos = snapshot.data;
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Text(todos[index].title);
            },
            itemCount: todos.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, CreateTodo.route);
          setState(() {});
        },
      ),
    );
  }
}
