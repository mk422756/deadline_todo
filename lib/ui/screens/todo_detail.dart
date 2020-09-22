import 'package:deadline_todo/models/progress.dart';
import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/providers/progress_provider.dart';
import 'package:deadline_todo/providers/todo_provider.dart';
import 'package:deadline_todo/ui/screens/progress_input.dart';
import 'package:deadline_todo/ui/screens/update_todo.dart';
import 'package:flutter/material.dart';

class TodoDetail extends StatefulWidget {
  static final route = "/todo_detail";
  @override
  _TodoDetailState createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  Future<int> deleteTodo(Todo todo) {
    TodoProvider provider = TodoProvider();
    return provider.delete(todo.id);
  }

  Future<List<Progress>> getProgresses(int todoId) {
    ProgressProvider provider = ProgressProvider();
    return provider.getByTodoId(todoId);
  }

  @override
  Widget build(BuildContext context) {
    Todo todo = ModalRoute.of(context).settings.arguments;
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
              child: Text("進捗追加"),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  ProgressInput.route,
                  arguments: todo,
                );
              },
            ),
            RaisedButton(
              child: Text("更新"),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () async {
                var retTodo = await Navigator.pushNamed(
                  context,
                  UpdateTodo.route,
                  arguments: todo,
                );
                setState(() {
                  todo = retTodo;
                });
              },
            ),
            RaisedButton(
              child: Text("削除"),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () async {
                await deleteTodo(todo);
                Navigator.pop(context);
              },
            ),
            Text('進捗一覧'),
            Expanded(
              child: FutureBuilder(
                future: getProgresses(todo.id),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  List<Progress> progresses = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var progress = progresses[index];
                      return Card(
                        child: ListTile(
                            title: Text(
                                '${progress.progress.toString()} ${progress.date.toString()}'),
                            onTap: () async {
                              await Navigator.pushNamed(
                                  context, TodoDetail.route,
                                  arguments: todo);
                              setState(() {});
                            }),
                      );
                    },
                    itemCount: progresses.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
