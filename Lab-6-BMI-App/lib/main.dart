/*
Name: Muhammad Umer
Roll No.: 19-NTU-CS-1157
Degree and Semester: BSIT-6th
*/

import 'package:flutter/material.dart';
import 'package:lab_6/ResultPage.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF11163B),
        ),
        scaffoldBackgroundColor: const Color(0xFF11163B),
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("BMI CALCULATOR"),
          ),
          body: const BmiHomePage(),
        ),
      ),
    ),
  );
}

double height = 100;
double weight = 25;

class BmiHomePage extends StatefulWidget {
  const BmiHomePage({Key? key}) : super(key: key);

  @override
  State<BmiHomePage> createState() => _BmiHomePageState();
}

class _BmiHomePageState extends State<BmiHomePage> {
  Color maleCardColor = const Color(0xFF272A4E);
  Color femaleCardColor = const Color(0xFF272A4E);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  maleCardColor = const Color.fromARGB(255, 47, 52, 105);
                  femaleCardColor = const Color(0xFF272A4E);
                  weight = 25;
                });
              },
              child: GenderCard(
                const Text("Male",
                    style:
                        TextStyle(color: Color.fromARGB(255, 133, 134, 153))),
                const Icon(
                  Icons.male,
                  size: 60,
                ),
                maleCardColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  femaleCardColor = const Color.fromARGB(255, 47, 52, 105);
                  maleCardColor = const Color(0xFF272A4E);
                  weight = 25;
                });
              },
              child: GenderCard(
                const Text("Female",
                    style:
                        TextStyle(color: Color.fromARGB(255, 133, 134, 153))),
                const Icon(
                  Icons.female,
                  size: 60,
                ),
                femaleCardColor,
              ),
            ),
          ],
        ),
        const DecoratedSlider(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomContainer(25, "WEIGHT"),
            BottomContainer(15, "AGE"),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultWidget(height, weight),
                ));
          },
          child: const Text(
            "CALCULATE",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 150, vertical: 25)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFC83558))),
        )
      ],
    );
  }
}

class BottomContainer extends StatefulWidget {
  int cardValue;
  final String cardText;
  BottomContainer(this.cardValue, this.cardText);

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.cardText,
              style: const TextStyle(color: Color.fromARGB(255, 133, 134, 153)),
            ),
            Text(
              widget.cardValue.toString(),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.cardValue++;
                      if (widget.cardText == "WEIGHT") {
                        weight = widget.cardValue.toDouble();
                      }
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF5D5E6F)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.cardValue--;
                      if (widget.cardText == "WEIGHT") {
                        weight = widget.cardValue.toDouble();
                      }
                    });
                  },
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF5D5E6F)),
                  ),
                )
              ],
            )
          ],
        ),
        const Color(0xFF272A4E),
        150);
  }
}

class DecoratedSlider extends StatefulWidget {
  const DecoratedSlider({Key? key}) : super(key: key);

  @override
  State<DecoratedSlider> createState() => _DecoratedSliderState();
}

class _DecoratedSliderState extends State<DecoratedSlider> {
  double sliderValue = 100;
  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Height",
                style: TextStyle(color: Color.fromARGB(255, 133, 134, 153))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sliderValue.round().toString(),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text("cm")
              ],
            ),
            SliderTheme(
              data: const SliderThemeData(
                activeTrackColor: Color(0xFFC83558),
                inactiveTrackColor: Color(0xFF787784),
                thumbColor: Color(0xFFC83558),
                overlayColor: Color.fromARGB(106, 200, 53, 87),
              ),
              child: Slider(
                min: 100,
                max: 200,
                value: sliderValue,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                    height = sliderValue.toDouble();
                  });
                },
              ),
            )
          ],
        ),
        const Color(0xFF272A4E),
        340);
  }
}

class GenderCard extends StatelessWidget {
  final Text cardText;
  final Icon cardIcon;
  final Color cardColor;

  GenderCard(this.cardText, this.cardIcon, this.cardColor);

  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cardIcon,
            cardText,
          ],
        ),
        cardColor,
        150);
  }
}

class DecoratedCard extends StatelessWidget {
  final Column cardColumn;
  final Color cardColor;
  final double cardWidth;

  DecoratedCard(this.cardColumn, this.cardColor, this.cardWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 125,
        width: cardWidth,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: cardColumn);
  }
}
