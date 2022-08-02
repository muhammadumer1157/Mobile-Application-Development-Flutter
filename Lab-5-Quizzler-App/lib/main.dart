/*
Name: Muhammad Umer
Roll No.: 19-NTU-CS-1157
Degree and Semester: BSIT-6th
*/

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Quizzler App"),
        ),
        body: const QuizzlerApp(),
        backgroundColor: Colors.black,
      ),
    ),
  );
}

class QuizzlerApp extends StatefulWidget {
  const QuizzlerApp({Key? key}) : super(key: key);

  @override
  State<QuizzlerApp> createState() => _QuizzlerAppState();
}

class _QuizzlerAppState extends State<QuizzlerApp> {
  List<String> questions = [
    "Question 1\n Is 2+2=4?",
    "Question 2\n Is 3*3=12?",
    "Question 3\n Is 9/3=3?",
    "End of Quiz"
  ];
  List<bool> answers = [true, false, true];
  List<Widget> results = [];
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 200,
        ),
        Expanded(
          child: Container(
            child: Text(
              questions[counter],
              style: const TextStyle(color: Colors.white, fontSize: 50),
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 150, vertical: 20),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          onPressed: () {
            setState(() {
              if (answers[counter] == true) {
                results.add(const Icon(Icons.check_circle_outline,
                    size: 40, color: Colors.green));
              } else {
                results.add(const Icon(Icons.highlight_off,
                    size: 40, color: Colors.red));
              }
              if (counter < questions.length) {
                counter++;
              }
            });
          },
          child: const Text(
            "True",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 145, vertical: 20),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          onPressed: () {
            setState(() {
              if (answers[counter] == false) {
                results.add(const Icon(Icons.check_circle_outline,
                    size: 40, color: Colors.green));
              } else {
                results.add(const Icon(Icons.highlight_off,
                    size: 40, color: Colors.red));
              }
              if (counter < questions.length) {
                counter++;
              }
            });
          },
          child: const Text(
            "False",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: results,
        )
      ],
    );
  }
}
