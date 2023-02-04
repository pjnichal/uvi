import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 13, 195, 250),
            minRadius: 40,
            child: Icon(
              Icons.person,
              color: Colors.black87,
              size: 50,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Name",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextField(
            decoration:
                InputDecoration(hintText: "Pravin Nichal", enabled: false),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Contact Number",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextField(
            decoration: InputDecoration(hintText: "7506769451", enabled: false),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Email Id",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "nichal.pravin2001@gmail.com",
              enabled: false,
            ),
          ),
        ],
      ),
    );
  }
}
