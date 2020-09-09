import 'package:deadline_todo/utils/db_client.dart';
import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  static final route = "/";

  @override
  Widget build(BuildContext context) {
    var dbClient = DBClient();
    dbClient.getDb();

    return Scaffold(
      body: Center(
        child: Text('hello world'),
      ),
    );
  }
}
