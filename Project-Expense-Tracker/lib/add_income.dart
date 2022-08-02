import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({Key? key}) : super(key: key);

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final TextEditingController _amount = TextEditingController();
  String _dropDownValue = '1';
  FirebaseFirestore db = FirebaseFirestore.instance;
  String docId = "";
  bool found = false;

  void checkDocandSetId() {
    final colRef =
        db.collection("Expenses").doc(getUserId()).collection("IncomeData");
    colRef
        .where('Month', isEqualTo: DateTime.now().month)
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        docId = doc.id;
        found = true;
      }
    });
  }

  String? getUserId() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser?.uid;
    }
    return "";
  }

  @override
  void initState() {
    checkDocandSetId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Add Income',
                      style: Theme.of(context).textTheme.headline1,
                    )),
                Image.asset(
                  'assets/addIncome.jpg',
                  height: 250,
                  width: 250,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    RegExp regex = RegExp(r'[0-9]{1,20}');
                    var textNotNull = text ?? "";
                    if (textNotNull.isEmpty) {
                      return 'Amount is required';
                    } else if (!regex.hasMatch(textNotNull)) {
                      return 'Amount not valid';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Amount',
                      hintText: 'Enter Amount'),
                  onChanged: (value) {
                    _amount.text = value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Month:  ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: const Color(0xFF1F1E3E),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                      child: DropdownButton<String>(
                        value: _dropDownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: Theme.of(context).textTheme.bodyText1,
                        underline: const SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropDownValue = newValue!;
                          });
                        },
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    try {
                      final data = <String, dynamic>{
                        'Income': double.parse(_amount.text),
                        'Month': int.parse(_dropDownValue),
                        'Remaining': double.parse(_amount.text)
                      };
                      checkDocandSetId();
                      if (found == false) {
                        db
                            .collection("Expenses")
                            .doc(getUserId())
                            .collection("IncomeData")
                            .add(data)
                            .then((DocumentReference doc) {
                          Flushbar(
                            margin: const EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(8),
                            flushbarStyle: FlushbarStyle.FLOATING,
                            backgroundColor: const Color(0xFFF2F7FA),
                            icon: const Icon(
                              Icons.check_circle_outline_outlined,
                              size: 28.0,
                              color: Colors.green,
                            ),
                            titleText: Text(
                              'Add Success',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            messageText: Text(
                              'Income is added!',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        });
                      } else {
                        db
                            .collection("Expenses")
                            .doc(getUserId())
                            .collection("IncomeData")
                            .doc(docId)
                            .set(data, SetOptions(merge: true));
                        Flushbar(
                          margin: const EdgeInsets.all(8),
                          borderRadius: BorderRadius.circular(8),
                          flushbarStyle: FlushbarStyle.FLOATING,
                          backgroundColor: const Color(0xFFF2F7FA),
                          icon: const Icon(
                            Icons.check_circle_outline_outlined,
                            size: 28.0,
                            color: Colors.green,
                          ),
                          titleText: Text(
                            'Add Success',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          messageText: Text(
                            'Income is added!',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      }
                    } catch (error) {
                      Flushbar(
                        margin: const EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(8),
                        flushbarStyle: FlushbarStyle.FLOATING,
                        backgroundColor: const Color(0xFFF2F7FA),
                        icon: const Icon(
                          Icons.highlight_off_outlined,
                          size: 28.0,
                          color: Colors.red,
                        ),
                        titleText: Text('Add Failed',
                            style: Theme.of(context).textTheme.bodyText2),
                        messageText: Text('Something went wrong!',
                            style: Theme.of(context).textTheme.bodyText1),
                        duration: const Duration(seconds: 3),
                      ).show(context);
                    }
                  },
                  child: const Text('Add Income'),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
