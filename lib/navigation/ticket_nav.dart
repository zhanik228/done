import 'package:flutter/material.dart';
import 'package:flutter_wsk_pro/pages/tickets/ticket_create.dart';
import 'package:flutter_wsk_pro/pages/tickets/ticket_list.dart';

GlobalKey<NavigatorState> ticketNavKey = GlobalKey<NavigatorState>();

class TicketNav extends StatelessWidget {
  const TicketNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: ticketNavKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder:(context) {
            if (settings.name == '/ticketCreate') {
              return TicketCreate(); 
            }

            return TicketList(); 
          },
        );
      },
    );
  }
}