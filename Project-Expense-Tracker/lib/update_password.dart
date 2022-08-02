import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  String _password = "";

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
                    child: Text('Update Password',
                        style: Theme.of(context).textTheme.headline1)),
                Image.asset(
                  'assets/updatePassword.webp',
                  height: 250,
                  width: 250,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: Theme.of(context).textTheme.bodyText1,
                  obscureText: true,
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
                    onPressed: () {
                      try {
                        FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) async {
                          if (user != null) {
                            try {
                              await user.updatePassword(_password);
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
                                titleText: Text('Update Failed',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                messageText: Text('Something went wrong!',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                duration: const Duration(seconds: 3),
                              ).show(context);
                            }
                          }
                        });
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
                          titleText: Text('Update Success',
                              style: Theme.of(context).textTheme.bodyText2),
                          messageText: Text('Password is updated!',
                              style: Theme.of(context).textTheme.bodyText1),
                          duration: const Duration(seconds: 3),
                        ).show(context);
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
                          titleText: Text('Update Failed',
                              style: Theme.of(context).textTheme.bodyText2),
                          messageText: Text('Something went wrong!',
                              style: Theme.of(context).textTheme.bodyText1),
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      }
                    },
                    child: const Text('Update')),
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
