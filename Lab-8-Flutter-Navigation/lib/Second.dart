import 'package:flutter/material.dart';

class Show extends StatelessWidget {
  String data;
  Show(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data),
      ),
    );
  }
}
