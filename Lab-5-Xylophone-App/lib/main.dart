/*
Name: Muhammad Umer
Roll No.: 19-NTU-CS-1157
Degree and Semester: BSIT-6th
*/

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: XylophonePage(),
      ),
    ),
  );
}

class XylophonePage extends StatelessWidget {
  const XylophonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            onPressed: () {
              final AudioCache player = AudioCache();
              player.play('assets_note1.wav');
            },
            child: Container(),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
            ),
            onPressed: () {
              final AudioCache player = AudioCache();
              player.play('assets_note2.wav');
            },
            child: Container(),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
            ),
            onPressed: () {
              final AudioCache player = AudioCache();
              player.play('assets_note3.wav');
            },
            child: Container(),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightGreen),
            ),
            onPressed: () {
              final AudioCache player = AudioCache();
              player.play('assets_note4.wav');
            },
            child: Container(),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            onPressed: () {
              final AudioCache player = AudioCache();
              player.play('assets_note5.wav');
            },
            child: Container(),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightBlue),
            ),
            onPressed: () {
              final AudioCache player = AudioCache();
              player.play('assets_note6.wav');
            },
            child: Container(),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
            ),
            onPressed: () {
              final AudioCache player = AudioCache();
              player.play('assets_note7.wav');
            },
            child: Container(),
          ),
        ),
      ],
    );
  }
}
