import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.blue[400],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text(
                "Dicey",
                style: TextStyle(
                    fontFamily: 'Lato', fontSize: 35, color: Colors.white),
              ),
            ]),
            DiceyApp(1),
            DiceyApp(2),
            DiceyApp(3)
          ],
        ),
      ),
    ),
  ));
}

class DiceyApp extends StatefulWidget {
  int start;
  DiceyApp(this.start);

  @override
  State<DiceyApp> createState() => _DiceyAppState(this.start);
}

class _DiceyAppState extends State<DiceyApp> {
  int? dice;
  _DiceyAppState(this.dice);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 200,
        child: GestureDetector(
          onTap: () {
            setState(() {
              dice = Random().nextInt(6) + 1;
            });
            AudioCache player = AudioCache();
            player.play('assets_note1.wav');
          },
          child: Image(
            image: AssetImage('images/dice$dice.png'),
          ),
        ));
  }
}
