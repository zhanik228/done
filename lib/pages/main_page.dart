import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wsk_pro/navigation/event_nav.dart';
import 'package:flutter_wsk_pro/navigation/ticket_nav.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    eventNavKey,
    ticketNavKey
  ];

  Future<bool> _onBackButtonPressed () async {
    if (_navigatorKeys[_selectedIndex].currentState?.canPop() == true) {
      _navigatorKeys[_selectedIndex].currentState
        ?.pop(_navigatorKeys[_selectedIndex].currentContext);
      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: 'Tickets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: 'Records',
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            EventNav(),
            TicketNav(),
          ],
        ),
      ),
    );
  }
}