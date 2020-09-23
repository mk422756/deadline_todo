import 'package:deadline_todo/models/progress.dart';
import 'package:deadline_todo/models/todo.dart';
import 'package:deadline_todo/providers/progress_provider.dart';
import 'package:deadline_todo/ui/screens/todo_detail.dart';
import 'package:deadline_todo/utils/db_helper.dart';
import 'package:flutter/material.dart';

class ProgressInput extends StatefulWidget {
  static final route = "/progress_input";
  @override
  _ProgressInputState createState() => _ProgressInputState();
}

class _ProgressInputState extends State<ProgressInput> {
  int selectedProgress = 1;

  Future<Progress> insertProgress(Progress progress) {
    ProgressProvider provider = ProgressProvider(DBHelper());
    return provider.insert(progress);
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
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedProgress = 1;
                    });
                  },
                  color: selectedProgress == 1 ? Colors.blue : Colors.grey,
                  child: Text('very good'),
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedProgress = 2;
                    });
                  },
                  color: selectedProgress == 2 ? Colors.blue : Colors.grey,
                  child: Text('good'),
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedProgress = 3;
                    });
                  },
                  color: selectedProgress == 3 ? Colors.blue : Colors.grey,
                  child: Text('so-so'),
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      selectedProgress = 4;
                    });
                  },
                  color: selectedProgress == 4 ? Colors.blue : Colors.grey,
                  child: Text('not good'),
                )
              ],
            ),
            RaisedButton(
              child: Text("OK"),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () async {
                Progress progress =
                    Progress(todo.id, selectedProgress, DateTime.now());
                await insertProgress(progress);
                await Navigator.popAndPushNamed(context, TodoDetail.route,
                    arguments: todo);
              },
            ),
          ],
        ),
      ),
    );
  }
}
