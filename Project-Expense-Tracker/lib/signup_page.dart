import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  String _username = "";
  String _password = "";
  String _email = "";

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
                      'Sign Up',
                      style: Theme.of(context).textTheme.headline1,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/signUpPage.jpg',
                  height: 250,
                  width: 250,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Name'),
                  onChanged: (text) {
                    _username = text;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    RegExp regex =
                        RegExp(r'[a-zA-z0-9]{3,20}@[a-zA-z0-9]{3,20}\.com');
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
                    hintText: 'Enter Password',
                  ),
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: _email,
                          password: _password,
                        );
                        await credential.user?.updateDisplayName(_username);
                        final userEmail = credential.user!.email ?? "";
                        // ignore: use_build_context_synchronously
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
                          // ignore: use_build_context_synchronously
                          titleText: Text('Sign Up Success',
                              // ignore: use_build_context_synchronously
                              style: Theme.of(context).textTheme.bodyText2),
                          messageText:
                              // ignore: use_build_context_synchronously
                              Text('User created with email: $userEmail!',
                                  // ignore: use_build_context_synchronously
                                  style: Theme.of(context).textTheme.bodyText1),
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
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
                            titleText: Text('Sign Up Failed',
                                style: Theme.of(context).textTheme.bodyText2),
                            messageText: Text('Password provided is too weak!',
                                style: Theme.of(context).textTheme.bodyText1),
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        } else if (e.code == 'email-already-in-use') {
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
                            titleText: Text('Sign Up Failed',
                                style: Theme.of(context).textTheme.bodyText2),
                            messageText: Text('Account already exists!',
                                style: Theme.of(context).textTheme.bodyText1),
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        }
                      } catch (e) {
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
                          titleText: Text('Sign Up Failed',
                              style: Theme.of(context).textTheme.bodyText2),
                          messageText: Text('Something went wrong!',
                              style: Theme.of(context).textTheme.bodyText1),
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      }
                    },
                    child: const Text('Sign Up')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Back"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
