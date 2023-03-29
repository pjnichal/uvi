import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uvi/login.dart';
import 'constants/constants.dart' as constants;
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _contactNo = TextEditingController();
  Future<int?> signUp(String email, String password, String mobile) async {
    final data = await http.get(
      Uri.parse(
          '${constants.apiLink}/credentials.php?email=$email&pass=$password&mbno=$mobile&action=signin'),
    );

    final jsondata = jsonDecode(data.body.toString());

    if (jsondata != null && jsondata['msg'] == "Email_Exists") {
      return -1;
    }
    if (jsondata != null && jsondata['msg'] == "Invalid_Mobo") {
      return 0;
    }
    if (jsondata != null && jsondata['msg'] == "Account Created") {
      return 1;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "UVI",
          style: TextStyle(color: constants.textColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Email Id",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(controller: _email),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Contact No",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(controller: _contactNo),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(controller: _password),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      onPressed: () async {
                        int? status = await signUp(
                            _email.text, _password.text, _contactNo.text);
                        if (status == 1) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) => const LoginPage())));
                        }
                        if (status == -1) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Email used is already exists'),
                          ));
                        }
                        if (status == 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please enter valid mobile number'),
                          ));
                        }
                      },
                      child: Text("Register")))
            ],
          ),
        ),
      ),
    );
  }
}
