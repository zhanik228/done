import 'package:flutter/material.dart';
import 'package:flutter_wsk_pro/pages/events/event_details.dart';
import 'package:flutter_wsk_pro/pages/events/event_list.dart';

GlobalKey<NavigatorState> eventNavKey = GlobalKey<NavigatorState>();

class EventNav extends StatelessWidget {
  const EventNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: eventNavKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder:(context) {
            if (settings.name == '/eventDetails') {
              return const EventDetails();
            }

            return const EventList();
          },
        );
      },
    );
  }
}