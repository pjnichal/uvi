import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvi/widgets/membershipcard.dart';
import 'constants/constants.dart' as constants;
import 'model/detail.dart';
import 'package:http/http.dart' as http;

class Membership extends StatefulWidget {
  const Membership({super.key});

  @override
  State<Membership> createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {
  Future<List<Detail>> getData() async {
    List<Detail> list = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final data = await http.get(
      Uri.parse(
          '${constants.apiLink}/getvalidators.php?user_id=$userId&action=getvalidators'),
    );
    final jsondata = jsonDecode(data.body);
    print(jsondata.runtimeType);

    for (Map i in jsondata) {
      list.add(Detail(
          fromDate: i['from_date'],
          isTicket: i['is_ticket'],
          toDate: i['to_date'],
          validatingParameter: i['validating_parameter']));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Center(child: Text("No data found"));
            }
          }
          if (snapshot.hasData) {
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: [
                ...snapshot.data!
                    .where((element) => (element.isTicket == 0))
                    .map((e) => MembershipCard(
                          primary: e.validatingParameter!,
                          second: "from ${e.fromDate!} to ${e.toDate!}",
                        ))
                    .toList()
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
