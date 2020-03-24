import 'package:flutter/material.dart';
import 'package:quiz_covid19/pages/quiz_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz COVID-19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}