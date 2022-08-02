import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class Calculator extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "";
  String expression = "";

  fetchResults() async {
    String uri = 'http://api.mathjs.org/v4/?expr=$expression';
    var url = Uri.parse(uri);
    http.Response response = await http.get(url);
    var responseBody = response.body;
    setState(() {
      result = responseBody.toString();
    });
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "C") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('+', '%2B');
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          fetchResults();
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget createButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80), color: buttonColor),
      child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          child:
              Text(buttonText, style: Theme.of(context).textTheme.headline6)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF1F1E3E),
                      )),
                  Text("Calculator",
                      style: Theme.of(context).textTheme.headline1),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  equation,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Text(
                  result,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const Expanded(
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 275,
                    child: Table(
                      children: [
                        TableRow(children: [
                          createButton("AC", 1, const Color(0xFFEB2323)),
                          createButton("C", 1, const Color(0xFF9DA1A9)),
                          createButton("÷", 1, const Color(0xFF3161BB)),
                        ]),
                        TableRow(children: [
                          createButton("7", 1, const Color(0xFF10203E)),
                          createButton("8", 1, const Color(0xFF10203E)),
                          createButton("9", 1, const Color(0xFF10203E)),
                        ]),
                        TableRow(children: [
                          createButton("4", 1, const Color(0xFF10203E)),
                          createButton("5", 1, const Color(0xFF10203E)),
                          createButton("6", 1, const Color(0xFF10203E)),
                        ]),
                        TableRow(children: [
                          createButton("1", 1, const Color(0xFF10203E)),
                          createButton("2", 1, const Color(0xFF10203E)),
                          createButton("3", 1, const Color(0xFF10203E)),
                        ]),
                        TableRow(children: [
                          createButton(".", 1, const Color(0xFF10203E)),
                          createButton("0", 1, const Color(0xFF10203E)),
                          createButton("00", 1, const Color(0xFF10203E)),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 95,
                    child: Table(
                      children: [
                        TableRow(children: [
                          createButton("×", 1, const Color(0xFF3161BB)),
                        ]),
                        TableRow(children: [
                          createButton("-", 1, const Color(0xFF3161BB)),
                        ]),
                        TableRow(children: [
                          createButton("+", 1, const Color(0xFF3161BB)),
                        ]),
                        TableRow(children: [
                          createButton("=", 2, const Color(0xFFEB2323)),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
