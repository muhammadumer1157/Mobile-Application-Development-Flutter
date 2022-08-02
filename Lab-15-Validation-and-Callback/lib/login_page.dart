import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:lab_14/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: LoginDesign(),
      ),
    );
  }
}

class LoginDesign extends StatelessWidget {
  LoginDesign({Key? key}) : super(key: key);

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              RegExp regex = RegExp(r'[a-zA-z0-9]{3,20}@student\.ntu\.edu\.pk');
              var textNotNull = text ?? "";
              if (textNotNull.isEmpty) {
                return 'Email is required';
              } else if (!regex.hasMatch(textNotNull)) {
                return 'Email not valid';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter email:',
            ),
            onChanged: (text) {
              email = text;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              RegExp regex =
                  RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
              var textNotNull = text ?? "";
              if (textNotNull.isEmpty) {
                return 'Password is required';
              } else if (!regex.hasMatch(textNotNull)) {
                return 'Password not valid';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter password:',
            ),
            onChanged: (value) {
              password = value;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          IconButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password);
                  final userEmail = credential.user!.email ?? "";
                  // ignore: use_build_context_synchronously
                  Flushbar(
                    backgroundColor: Colors.green,
                    titleText: const Text('Login Success'),
                    messageText: Text('Logged in as: $userEmail'),
                    duration: const Duration(seconds: 3),
                  ).show(context);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    Flushbar(
                      backgroundColor: Colors.red,
                      titleText: const Text('Login failed'),
                      messageText: const Text('User not found'),
                      duration: const Duration(seconds: 3),
                    ).show(context);
                  } else if (e.code == 'wrong-password') {
                    Flushbar(
                      backgroundColor: Colors.red,
                      titleText: const Text('Login failed'),
                      messageText: const Text('Wrong password'),
                      duration: const Duration(seconds: 3),
                    ).show(context);
                  }
                }
              },
              icon: const Icon(Icons.login))
        ],
      ),
    );
  }
}
