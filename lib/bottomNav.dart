import 'package:cs4750app/account_page.dart';
import 'package:cs4750app/homescreen.dart';
import 'package:cs4750app/list_page.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final screens = [
    HomeScreen(),
    ListPage(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_rounded),
            // activeIcon: Icon(Icons.forum_rounded, color: Colors.orange,),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            // activeIcon: Icon(Icons.list_rounded, color: Colors.orange,),
            label: 'My Lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
