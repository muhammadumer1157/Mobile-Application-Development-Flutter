import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class UpdateName extends StatelessWidget {
  UpdateName({Key? key}) : super(key: key);
  String _name = "";
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
                    child: Text('Update Name',
                        style: Theme.of(context).textTheme.headline1)),
                Image.asset(
                  'assets/updateName.webp',
                  height: 250,
                  width: 250,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Name'),
                  onChanged: (value) {
                    _name = value;
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
                              await user.updateDisplayName(_name);
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
                          messageText: Text('Name is updated!',
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
                          titleText: Text('Update failed',
                              style: Theme.of(context).textTheme.bodyText2),
                          messageText: Text('Something went wrong!',
                              style: Theme.of(context).textTheme.bodyText1),
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      }
                    },
                    child: const Text('Save')),
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
