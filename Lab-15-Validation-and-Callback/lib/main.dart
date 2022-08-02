import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool loggedIn = false;
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    loggedIn = true;
  }
  runApp(loggedIn ? const HomePage() : const LoginPage());
}
