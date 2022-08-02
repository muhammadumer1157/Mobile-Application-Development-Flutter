import 'package:expense_tracker/update_name.dart';
import 'package:expense_tracker/update_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'update_name.dart';
import 'update_password.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  void getUserData() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _name.text = user.displayName!;
          _email.text = user.email!;
        });
      }
    });
  }

  @override
  void initState() {
    getUserData();
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
                    "Profile",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Image.asset(
                  'assets/signUpPage.jpg',
                  height: 250,
                  width: 250,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 322.5,
                      child: TextField(
                        enabled: false,
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: _name,
                        decoration: const InputDecoration(
                          disabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateName()))
                              .then((_) {
                            getUserData();
                            setState(() {});
                          });
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  enabled: false,
                  style: Theme.of(context).textTheme.bodyText1,
                  controller: _email,
                  decoration: const InputDecoration(
                    disabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UpdatePassword()))
                          .then((_) {
                        getUserData();
                        setState(() {});
                      });
                    },
                    child: const Text('Click to Update Password')),
                const SizedBox(height: 5),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFE80000))),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: const Text(
                    "Logout",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
