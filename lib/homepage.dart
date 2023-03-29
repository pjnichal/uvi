import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvi/main.dart';
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
  final list = const [Ticket(), Membership()];
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear().then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UVI(),
                        ));
                  });
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
          title: const Text(
            "UVI",
            style: TextStyle(color: constants.textColor),
          ),
          centerTitle: true,
          backgroundColor: constants.primary,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currIndex,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          fixedColor: constants.primary,

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
            // BottomNavigationBarItem(
            //   label: "Profile",
            //   icon: Icon(Icons.person),
            // ),
          ],
          // selectedItemColor: constants.secColor,
          elevation: 2,
        ),
        body: list[currIndex]);
  }
}
