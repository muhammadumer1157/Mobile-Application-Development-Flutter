import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        cardTheme: const CardTheme(elevation: 2, color: Color(0xFFFFFFFF)),
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Color(0xFF000000)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF0039A5)))),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF00B6E4),
            foregroundColor: Color(0xFFFFFFFF)),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(const Color(0xFF3161BB)),
          textStyle: MaterialStateProperty.all(
              const TextStyle(fontFamily: 'Lato', fontSize: 17)),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(const TextStyle(
                color: Color(0xFFFFFFFF), fontFamily: 'Lato', fontSize: 17)),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFF234483),
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFFFFFFF),
          selectedItemColor: Color(0xFF324B7C),
          selectedLabelStyle:
              TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold),
          selectedIconTheme: IconThemeData(color: Color(0xFF324B7C)),
          unselectedIconTheme: IconThemeData(color: Color(0xFF9DA1A9)),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontFamily: 'Lato',
              fontSize: 35,
              color: Color(0xFF1F1E3E),
              fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontFamily: 'Lato',
              fontSize: 25,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold),
          headline3: TextStyle(
              fontFamily: 'Lato',
              fontSize: 25,
              color: Color(0xFF1F1E3E),
              fontWeight: FontWeight.bold),
          headline4: TextStyle(
              fontFamily: 'Lato',
              fontSize: 35,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold),
          headline5: TextStyle(
              fontFamily: 'Lato',
              fontSize: 30,
              color: Color(0xFF1F1E3E),
              fontWeight: FontWeight.bold),
          headline6: TextStyle(
              fontFamily: 'Lato',
              fontSize: 30,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold),
          bodyText1: TextStyle(
            fontFamily: 'Lato',
            fontSize: 17,
            color: Color(0xFF1F1E3E),
          ),
          bodyText2: TextStyle(
              fontFamily: 'Lato',
              fontSize: 17,
              color: Color(0xFF1F1E3E),
              fontWeight: FontWeight.bold),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage()));
}
