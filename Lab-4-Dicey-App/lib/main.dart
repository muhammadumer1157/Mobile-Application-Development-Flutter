/*
Name: Muhammad Umer
Roll No.: 19-NTU-CS-1157
Degree and Semester: BSIT-6th
*/

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatefulWidget {
  const DiceApp({Key? key}) : super(key: key);

  @override
  State<DiceApp> createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> {
  int dice = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dice = Random().nextInt(6) + 1;
                });
              },
              child: Image(
                image: AssetImage('images/dice$dice.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
