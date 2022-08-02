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
          title: const Text("I Am Rick"),
          backgroundColor: Colors.red,
        ),
        body: const Center(
          child: Image(
            image: AssetImage('images/rick.jpg'),
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
    ),
  );
}
