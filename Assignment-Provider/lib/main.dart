import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderApp());
}

class DataModel with ChangeNotifier {
  String text1 = '';
  String text2 = '';

  void addText1(String t1) {
    text1 = t1;
    notifyListeners();
  }

  void addText2(String t2) {
    text2 = t2;
    notifyListeners();
  }
}

class ProviderApp extends StatefulWidget {
  const ProviderApp({Key? key}) : super(key: key);

  @override
  State<ProviderApp> createState() => _ProviderAppState();
}

class _ProviderAppState extends State<ProviderApp> {
  List<Widget> textWidgets = [const TextFieldWidget()];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataModel>.value(
      value: DataModel(),
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xFF1560BD),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Consumer<DataModel>(
                    builder: (context, dataModel, child) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Text(
                              'Provider Assignment',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Text 1 :${dataModel.text1}',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Text 2 :${dataModel.text2}',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Column(children: textWidgets),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () {
                      setState(() {
                        textWidgets.add(const TextFieldWidget());
                      });
                    },
                    child: const Text(
                      "Add More",
                      style: TextStyle(color: Color(0xFF1AA7EC)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<DataModel>(
                    builder: (context, dataModel, child) {
                      return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        child: const Text('Save',
                            style: TextStyle(color: Color(0xFF1AA7EC))),
                        onPressed: () {
                          FirebaseFirestore db = FirebaseFirestore.instance;
                          Map<String, dynamic> data = {
                            'Text1': dataModel.text1,
                            'Text2': dataModel.text2,
                          };
                          db
                              .collection("Data")
                              .add(data)
                              .then((value) => Flushbar(
                                    title: 'Success',
                                    message:
                                        'Added Successfully! Values:${dataModel.text1} and ${dataModel.text2}',
                                    duration: const Duration(seconds: 10),
                                    backgroundColor: Colors.green,
                                  ).show(context))
                              .catchError(
                            (error) {
                              Flushbar(
                                title: 'Error',
                                message: 'Error $error',
                                duration: const Duration(seconds: 10),
                                backgroundColor: Colors.red,
                              ).show(context);
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({Key? key}) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<DataModel>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter text 1',
              label: Text('Text 1'),
            ),
            onChanged: (value) {
              providerObj.addText1(value);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter text 2',
              label: Text('Text 2'),
            ),
            onChanged: (value) {
              providerObj.addText2(value);
            },
          ),
        ],
      ),
    );
  }
}
