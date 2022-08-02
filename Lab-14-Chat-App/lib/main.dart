import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: Scaffold(body: MessagingHomePage()),
  ));
}

class MessagingHomePage extends StatefulWidget {
  const MessagingHomePage({Key? key}) : super(key: key);

  @override
  State<MessagingHomePage> createState() => _MessagingHomePageState();
}

class _MessagingHomePageState extends State<MessagingHomePage> {
  String msg = "";
  List<String> messages = [];
  final db = FirebaseFirestore.instance;

  void readData() {
    List<String> allMessages = [];
    final collectionRef = db.collection("message");
    collectionRef.orderBy('timestamp').snapshots().listen(
      (event) {
        for (var doc in event.docs) {
          allMessages.add(doc.data()["msg"]);
        }
        setState(() {
          messages.clear();
          messages = allMessages;
        });
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 400,
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              return Align(
                  alignment:
                      index % 2 == 0 ? Alignment.topRight : Alignment.topLeft,
                  child: MessageContainer(messages[index]));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Write Message',
                ),
                onChanged: (value) {
                  msg = value;
                },
              ),
            ),
            TextButton(
              onPressed: () {
                //print(msg);
                final msgToSave = <String, dynamic>{
                  'msg': msg,
                  'timestamp': DateTime.now().millisecondsSinceEpoch
                };

                db.collection("message").add(msgToSave).then(
                    (DocumentReference doc) =>
                        print("Added Data with ID: ${doc.id}"));
                readData();
              },
              child: const Icon(Icons.send),
            )
          ],
        )
      ],
    );
  }
}

class MessageContainer extends StatelessWidget {
  String message = "";
  MessageContainer(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.amber[100],
      ),
      height: 25,
      width: 100,
      child: Center(child: Text(message)),
    );
  }
}
