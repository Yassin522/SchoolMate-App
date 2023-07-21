import 'package:flutter/material.dart';

class TQuizz extends StatefulWidget {
  TQuizz({Key? key}) : super(key: key);

  @override
  State<TQuizz> createState() => _TQuizzState();
}

class _TQuizzState extends State<TQuizz> {
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Quizzes'),
      ),
    );
  }
}
