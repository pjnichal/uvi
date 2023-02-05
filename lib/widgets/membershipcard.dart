import 'package:flutter/material.dart';

class MembershipCard extends StatelessWidget {
  final String primary, second;
  const MembershipCard({
    super.key,
    required this.primary,
    required this.second,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 13, 195, 250),
            minRadius: 40,
            child: Icon(
              Icons.train,
              color: Colors.black87,
              size: 50,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            primary,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              second,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
