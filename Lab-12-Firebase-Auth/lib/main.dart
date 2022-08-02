import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_up.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: const SignInHomePage(),
    ),
  ));
}

class SignInHomePage extends StatefulWidget {
  const SignInHomePage({Key? key}) : super(key: key);

  @override
  State<SignInHomePage> createState() => _SignInHomePageState();
}

class _SignInHomePageState extends State<SignInHomePage> {
  String _username = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      .signInWithEmailAndPassword(
                          email: _username, password: _password);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              child: const Text("Login")),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
              },
              child: const Text("Sign Up"))
        ],
      ),
    );
  }
}
