import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class ResetPasswordPage extends StatelessWidget {
  String _email = "";
  ResetPasswordPage({Key? key}) : super(key: key);

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
                  'Reset Password',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Image.asset(
                'assets/resetPassword.webp',
                height: 250,
                width: 250,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                autofocus: true,
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
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _email);
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
                        titleText: Text('Success',
                            // ignore: use_build_context_synchronously
                            style: Theme.of(context).textTheme.bodyText2),
                        messageText: Text('Task completed!',
                            // ignore: use_build_context_synchronously
                            style: Theme.of(context).textTheme.bodyText2),
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
                        titleText: Text('Failed',
                            style: Theme.of(context).textTheme.bodyText2),
                        messageText: Text('Something went wrong!',
                            style: Theme.of(context).textTheme.bodyText1),
                        duration: const Duration(seconds: 3),
                      ).show(context);
                    }
                  },
                  child: const Text('Send Reset Email')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'))
            ],
          ),
        ),
      )),
    );
  }
}
