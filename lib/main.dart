import 'package:flutter/material.dart';

import 'package:uvi/login.dart';

void main() {
  runApp(const UVI());
}

class UVI extends StatelessWidget {
  const UVI({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
