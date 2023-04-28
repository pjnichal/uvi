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
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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
    print(userId);
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
          validatingParameter: i['validating_parameter'],
          isValidated: i['is_validated']));
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
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Up Comming Tickets",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ...data.map((e) {
                DateTime tempDate = DateFormat("dd-MM-yyyy").parse(e.fromDate!);

                if (e.isTicket == 0) {
                  return Container();
                } else if (e.isTicket == 1 &&
                    e.isValidated == 0 &&
                    (tempDate.compareTo(DateTime.now()) == 0 ||
                        tempDate.compareTo(DateTime.now()) > 0)) {
                  print("trueeeeeee");
                  return TicketCard(
                    primary: e.validatingParameter!,
                    second: e.fromDate!,
                  );
                } else {
                  return Container();
                }
              }).toList(),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Expired Tickets",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ...data.map((e) {
                DateTime tempDate = DateFormat("dd-MM-yyyy").parse(e.fromDate!);
                if ((e.isTicket == 1 && e.isValidated == 1) ||
                    (e.isTicket == 1 &&
                        tempDate.compareTo(DateTime.now()) < 0)) {
                  return TicketCard(
                    primary: e.validatingParameter!,
                    second: e.fromDate!,
                  );
                } else {
                  return Container();
                }
              }).toList(),
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
