import 'package:deadline_todo/screens/top_page.dart';
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
      },
    );
  }
}
