/*
Name: Muhammad Umer
Roll No.: 19-NTU-CS-1157
Degree and Semester: BSIT-6th
Lab No.:2
*/

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(""),
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                children: const [
                  Text("Text"),
                  Icon(Icons.hive),
                ],
              ),
              const Text("Text"),
            ],
          ),
        ),
      ),
    ),
  );
}
