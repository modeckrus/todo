import 'package:flutter/material.dart';
import 'package:todoapp/feautures/todo/presentation/pages/homepage.dart';
import 'injection_container.dart' as di;
void main()async{
  await di.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: HomePage(),
    );
  }
}