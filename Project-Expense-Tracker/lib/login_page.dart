import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reset_password_page.dart';
import 'signup_page.dart';
import 'bottom_appbar_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Expense Tracker',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Image.asset(
                    'assets/loginPage.jpg',
                    height: 250,
                    width: 250,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      RegExp regex = RegExp(
                          r'[a-zA-z0-9]{3,20}@[a-zA-z0-9\.]{3,20}\.[a-zA-z]{2,10}');
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
                        labelText: 'Email',
                        hintText: 'Enter Email'),
                    onChanged: (text) {
                      _email = text;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      RegExp regex = RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
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
                        labelText: 'Password',
                        hintText: 'Enter Password'),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPasswordPage()));
                        },
                        child: const Text('Forgotten Password?')),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomAppbarPage()),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            // ignore: use_build_context_synchronously
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
                              titleText: Text('Login Failed',
                                  style: Theme.of(context).textTheme.bodyText2),
                              messageText: Text('User not found!',
                                  style: Theme.of(context).textTheme.bodyText1),
                              duration: const Duration(seconds: 3),
                            ).show(context);
                          } else if (e.code == 'wrong-password') {
                            // ignore: use_build_context_synchronously
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
                              titleText: Text('Login Failed',
                                  style: Theme.of(context).textTheme.bodyText2),
                              messageText: Text('Wrong password!',
                                  style: Theme.of(context).textTheme.bodyText1),
                              duration: const Duration(seconds: 3),
                            ).show(context);
                          }
                        }
                      },
                      child: const Text('Login')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: const Text('Click to Sign Up')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
