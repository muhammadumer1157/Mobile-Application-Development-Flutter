import 'package:expense_tracker/add_expense.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'manage_page.dart';
import 'statistics_page.dart';
import 'add_expense.dart';

// ignore: use_key_in_widget_constructors
class BottomAppbarPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BottomAppbarPageState createState() => _BottomAppbarPageState();
}

class _BottomAppbarPageState extends State<BottomAppbarPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
    ManagePage(),
    AddExpense(),
    StatisticsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.format_align_center,
              ),
              label: 'Manage'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
