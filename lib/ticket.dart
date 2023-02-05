import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uvi/widgets/ticketcard.dart';
import 'constants/constants.dart' as constants;
import 'package:http/http.dart' as http;

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  String api =
      "${constants.apiLink}/getvalidators.php?nfc_id=987456&action=getvalidators";
  getData(int userId) async {
    final data = await http.get(Uri.parse(
        '${constants.apiLink}/getvalidators.php?user_id=$userId&action=getvalidators'));
    final jsondata = jsonDecode(data.body);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: ((context, index) {
      return const ListTile(
        title: TicketCard(),
      );
    }));
  }
}
