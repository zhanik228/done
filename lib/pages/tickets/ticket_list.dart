import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wsk_pro/models/ticket_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketList extends StatefulWidget {
  const TicketList({super.key});

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  late SharedPreferences _prefs;
  List<TicketModel> _tickets = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
      List<String>? tickets = _prefs.getStringList('tickets');
      if (tickets != null) {
        _tickets = tickets.map((e) => TicketModel.fromJson(json.decode(e))).toList();
      }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Tickets List'),),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed:() {
                Navigator.pushNamed(context, '/ticketCreate');
              },
              child: Text('Create a Ticket')
            ),
            Expanded(
              child: ReorderableListView(
                children: List.generate(
                    _tickets.length, 
                    (index) => Dismissible(
                      key: Key('$index'), 
                      child: ListTile(
                        key: Key('$index'),
                        title: Column(
                          children: [
                            Text('${_tickets[index].title}'),
                            Text('${_tickets[index].seat}')
                          ],
                        ),
                      )
                    )
                  ),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final item = _tickets.removeAt(oldIndex);
                    _tickets.insert(newIndex, item);
                  });
                },
                ),
            ),
          ],
        ),
      ),
    );
  }
}