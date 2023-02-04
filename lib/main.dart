import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvi/homepage.dart';

import 'package:uvi/login.dart';

void main() {
  runApp(UVI());
}

class UVI extends StatefulWidget {
  UVI({super.key});

  @override
  State<UVI> createState() => _UVIState();
}

class _UVIState extends State<UVI> {
  getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? _userId = pref.getInt("userId");
    return _userId;
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getdata(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
