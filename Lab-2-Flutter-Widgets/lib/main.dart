import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Text("BSIT - Lab 2"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: const [
                Text("BSIT"),
                Text("BSSE"),
                Text("BSCS"),
                Icon(Icons.add),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
