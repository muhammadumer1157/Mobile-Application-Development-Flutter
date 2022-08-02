import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _username = "";
  String _password = "";
  void showSnackBar(String text, Color color, BuildContext ctx) {
    final snack = SnackBar(
      content: Text(text),
      backgroundColor: color,
    );

    ScaffoldMessenger.of(ctx).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter email:',
              ),
              onChanged: (value) {
                _username = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter password:',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            TextButton(
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _username,
                      password: _password,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      showSnackBar('The password provided is too weak.',
                          Colors.red, context);
                    } else if (e.code == 'email-already-in-use') {
                      showSnackBar('The account already exists for that email.',
                          Colors.red, context);
                    }
                  } catch (e) {
                    showSnackBar("Something went wrong", Colors.red, context);
                  }
                },
                child: const Text("Sign Up")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back"))
          ],
        ),
      ),
    );
  }
}
