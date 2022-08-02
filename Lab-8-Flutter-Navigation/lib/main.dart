import 'package:flutter/material.dart';
import 'package:lab_8/Second.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(body: Center(child: Input())),
    ),
  );
}

class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  String value = "";
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter text',
          ),
          onChanged: (text) {
            value = text;
          },
        ),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Show(value)),
            );
          },
          child: const Text("Click"))
    ]);
  }
}
