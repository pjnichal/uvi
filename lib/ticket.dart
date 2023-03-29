import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvi/model/detail.dart';
import 'package:uvi/widgets/ticketcard.dart';
import 'constants/constants.dart' as constants;
import 'package:http/http.dart' as http;

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  Future<List<Detail>> getData() async {
    List<Detail> list = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final data = await http.get(
      Uri.parse(
          '${constants.apiLink}/uviuser/getvalidators.php?user_id=$userId&action=getvalidators'),
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
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        print(snapshot.hasData);

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return Center(child: Text("No data found"));
          }
        }
        if (snapshot.hasData) {
          final List<Detail>? data = snapshot.data;

          print(data!.first.fromDate);
          return ListView(
            children: [
              ...data.map((e) {
                if (e.isTicket == 0) {
                  return Container();
                } else {
                  return TicketCard(
                    primary: e.validatingParameter!,
                    second: e.fromDate!,
                  );
                }
              }).toList()
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
