import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Custom Widgets"),
        ),
        body: Column(
          children: [
            ContactWidget(
              const Icon(Icons.android),
              const Text("First Argument"),
            ),
            ContactWidget(
              const Icon(Icons.hive),
              const Text("Second Argument"),
            ),
            ContactWidget(const Icon(Icons.add), const Text("Third Argument")),
            // ContactWidget(),
          ],
        ),
      ),
    ),
  );
}

class ContactWidget extends StatelessWidget {
  final Icon contacticon;
  final Text contacttext;

  ContactWidget(this.contacticon, this.contacttext);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        contacticon,
        contacttext,
      ],
    );
  }
}
