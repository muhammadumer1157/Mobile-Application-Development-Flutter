import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  final textTile = ['OneText', 'TwoText', 'ThreeText'];
  final tileLabel = ['OneLabel', 'TwoLabel', 'ThreeLabel'];
  List tileValues = ["", "", ""];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('Item Count: $count'),
              Text('Value of first field:' + tileValues[0]),
              Text('Value of second field:' + tileValues[1]),
              Expanded(
                  child: ListView.builder(
                itemCount: textTile.length,
                itemBuilder: (context, index) {
                  return ListTilePage(tileLabel[index], textTile[index],
                      (receivedValue) {
                    setState(() {
                      tileValues[index] = receivedValue;
                    });
                  });
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class ListTilePage extends StatelessWidget {
  final String tileLabel;
  final String tileText;
  String tileValue = "";
  Function provideValueCallback;

  ListTilePage(this.tileLabel, this.tileText, this.provideValueCallback);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: tileLabel,
          hintText: tileText),
      onChanged: (text) {
        tileValue = text;
        provideValueCallback(tileValue);
      },
    );
  }
}
