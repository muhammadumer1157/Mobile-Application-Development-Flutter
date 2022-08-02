/*
Name: Muhammad Umer
Roll No.: 19-NTU-CS-1157
Degree and Semester: BSIT-6th
*/

import 'package:flutter/material.dart';

void main() {
  runApp(const ContactLayout());
}

class ContactLayout extends StatelessWidget {
  const ContactLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('images/img.png'),
                radius: 50,
              ),
              const Text(
                "Muhammad Umer",
                style: TextStyle(
                  fontFamily: 'ZenKurenaido',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Student",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                color: Colors.white,
                child: Row(
                  children: const [
                    Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "+923014192366",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                color: Colors.white,
                child: Row(
                  children: const [
                    Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "umeriftikhar16@gmail.com",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
