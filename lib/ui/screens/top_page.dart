import 'package:deadline_todo/models/progress.dart';
import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/providers/progress_provider.dart';
import 'package:deadline_todo/providers/todo_provider.dart';
import 'package:deadline_todo/ui/screens/todo_detail.dart';
import 'package:deadline_todo/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'create_todo.dart';

class TopPage extends StatefulWidget {
  static final route = "/";
  @override
  _TopPageState createState() => _TopPageState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _TopPageState extends State<TopPage> {
  Future<List<Todo>> getTodos() {
    TodoProvider provider = TodoProvider(DBHelper());
    return provider.getAll();
  }

  Future<List<Progress>> getProgresses() {
    ProgressProvider provider = ProgressProvider(DBHelper());
    return provider.getAll();
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  void initState() {
    super.initState();
//    _showNotification();
    TodoProvider provider = TodoProvider(DBHelper());
    provider.getByNotHasTodayProgress().then((todos) {
      notHaveTodayProgressTodo =
          todos.where((todo) => !todo.isFinished()).toList();
      setState(() {});
    });
  }

  List<Todo> notHaveTodayProgressTodo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await Navigator.pushNamed(context, CreateTodo.route);
                setState(() {});
              }),
        ],
      ),
      body: FutureBuilder(
        future: getTodos(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          List<Todo> todos = snapshot.data;
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              var todo = todos[index];
              return Card(
                child: ListTile(
                    title: Text(todo.title),
                    onTap: () async {
                      await Navigator.pushNamed(context, TodoDetail.route,
                          arguments: todo);
                      setState(() {});
                    }),
              );
            },
            itemCount: todos.length,
          );
        },
      ),
      floatingActionButton: notHaveTodayProgressTodo.length > 0
          ? FloatingActionButton.extended(
              onPressed: () {
                // TODO
              },
              label: Text(
                '進捗追加',
              ))
          : null,
    );
  }
}
