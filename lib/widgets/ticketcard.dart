import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/constants.dart' as constants;

class TicketCard extends StatelessWidget {
  final String primary, second;
  const TicketCard({
    super.key,
    required this.primary,
    required this.second,
  });

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
              children: [
                Text(
                  primary,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(second),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            const CircleAvatar(
              backgroundColor: constants.secColor,
              minRadius: 25,
              child: Icon(
                Icons.confirmation_num_outlined,
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
