// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:school_management_system/routes/app_pages.dart';
// import 'package:school_management_system/student/view/Adjuncts/Component/QuizBrain.dart';

// QuizBrain quizBrain = QuizBrain();

// class Quizzler extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade900,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10.0),
//           child: QuizPage(),
//         ),
//       ),
//     );
//   }
// }

// class QuizPage extends StatefulWidget {
//   QuizPage({this.id});
//   final id;
//   @override
//   _QuizPageState createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   List<Icon> scoreKeeper = [];

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Future,
//       initialData: InitialData,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         return ;
//       },
//     ),
//   }

//   void checkAnswer(bool userPickedAnswer) {
//     bool correctAnswer = quizBrain.getCorrectAnswer();
//     setState(() {
//       if (quizBrain.isFinished()) {
//         Get.defaultDialog(
//             title: 'You End the quiz!',
//             onConfirm: () {
//               Get.toNamed(AppPages.tadjuncts.toString());
//             });
//         quizBrain.reset();
//         scoreKeeper = [];
//       } else {
//         if (userPickedAnswer == correctAnswer) {
//           scoreKeeper.add(Icon(Icons.check, color: Colors.green));
//         } else {
//           scoreKeeper.add(Icon(Icons.close, color: Colors.red));
//         }
//         quizBrain.nextQuestion();
//       }
//     });
//   }
// }
