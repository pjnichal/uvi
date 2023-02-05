import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvi/homepage.dart';
import 'package:uvi/main.dart';
import 'package:uvi/signup.dart';
import 'constants/constants.dart' as constants;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  setUserId(int userId) async {
    SharedPreferences perf = await SharedPreferences.getInstance();
    perf.setInt("userId", userId);
  }

  Future<int?> signIn(String email, String password) async {
    final data = await http.get(
        Uri.parse(
            '${constants.apiLink}/credentials.php?email=${email}&pass=${password}&action=login'),
        headers: {
          "Cookie":
              "__test=cd0c60fc40e383295a552208f655657c;expires=2024-03-11T15:01:26.586Z; path=/"
        });
    print(data.body + "  ==========================");
    final jsondata = jsonDecode(data.body.toString());

    if (jsondata != null && jsondata['msg'] == "No_Acc") {
      return -1;
    }
    if (jsondata != null && jsondata['msg'] == "Valid") {
      return jsondata['user_id'];
    }

    return null;
  }

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
                "Password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(controller: _password),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        int? userId = await signIn(_email.text, _password.text);
                        if (userId == -1) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('User Not Found Create Account'),
                          ));
                        } else if (userId == null) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please Enter Correct Details'),
                          ));
                        } else {
                          setUserId(userId);
                          if (!mounted) return;
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => UVI(),
                          ));
                        }
                      },
                      child: Text("Login"))),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const SignupPage())));
                      },
                      child: Text("Register")))
            ],
          ),
        ),
      ),
    );
  }
}
