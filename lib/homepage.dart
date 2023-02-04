import 'package:flutter/material.dart';
import 'package:uvi/membership.dart';
import 'package:uvi/profile.dart';
import 'package:uvi/ticket.dart';
import 'constants/constants.dart' as constants;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final list = const [Ticket(), Membership(), Profile()];
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "UVI",
            style: TextStyle(color: constants.textColor),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currIndex,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          onTap: (value) {
            setState(() {
              currIndex = value;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: "Ticket",
              icon: Icon(Icons.receipt),
            ),
            BottomNavigationBarItem(
              label: "Membership",
              icon: Icon(Icons.calendar_month),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person),
            ),
          ],
          selectedItemColor: constants.secColor,
          elevation: 2,
        ),
        body: list[currIndex]);
  }
}
