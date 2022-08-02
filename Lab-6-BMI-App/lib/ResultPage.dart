import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final double height;
  final double weight;

  ResultWidget(this.height, this.weight);

  double calculateRange() {
    return weight / (height * height) * 10000;
  }

  String calculateResult3() {
    String bmiResult = "";
    double bmiRange = calculateRange();
    if (bmiRange < 18.5) {
      bmiResult = "You are Underweight";
    } else if (bmiRange >= 18.5 && bmiRange <= 24.9) {
      bmiResult = "You are Normal";
    } else if (bmiRange >= 25 && bmiRange <= 29.9) {
      bmiResult = "You are Overweight";
    } else if (bmiRange >= 30) {
      bmiResult = "You are Obese";
    }
    return bmiResult;
  }

  String calculateResult1() {
    String bmiResult = "";
    double bmiRange = calculateRange();
    if (bmiRange < 18.5) {
      bmiResult = "UNDERWEIGHT";
    } else if (bmiRange >= 18.5 && bmiRange <= 24.9) {
      bmiResult = "NORMAL";
    } else if (bmiRange >= 25 && bmiRange <= 29.9) {
      bmiResult = "OVERWEIGHT";
    } else if (bmiRange >= 30) {
      bmiResult = "OBESE";
    }
    return bmiResult;
  }

  String calculateResult2() {
    double bmiRange = calculateRange();
    return bmiRange.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI CALCULATOR"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Your Result',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 400,
                width: 340,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF272A4E),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      calculateResult1(),
                      style: const TextStyle(
                          color: Color(0xFF5CA27D),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Text(
                      calculateResult2(),
                      style: const TextStyle(
                          fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Text(
                      calculateResult3(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "RECALCULATE",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          horizontal: 125, vertical: 25)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFC83558))),
            )
          ],
        ),
      ),
    );
  }
}
