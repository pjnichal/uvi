import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/constants.dart' as constants;

class TicketCard extends StatelessWidget {
  const TicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: constants.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Primary Info",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 7,
                ),
                Text("Secondary Info"),
                SizedBox(
                  height: 5,
                ),
                Text("Date and time"),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            const CircleAvatar(
              backgroundColor: constants.secColor,
              minRadius: 25,
              child: Icon(
                Icons.train,
                color: Colors.black87,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
