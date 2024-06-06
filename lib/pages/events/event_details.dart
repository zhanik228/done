import 'package:flutter/material.dart';
import 'package:flutter_wsk_pro/models/event_model.dart';
import 'package:flutter_wsk_pro/pages/events/event_picture.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  void initPrefs () async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EventModel;
    final title = '${args.eventTitle}';
    final text = '${args.eventText}';

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Event Details'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Text('Total views: ${_prefs.getInt('${args.eventId}_view')}'),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder:(context) {
                      return EventPicture(image: 'assets/events_resources/images/${args.eventPictures?[0]}',);
                    },);
                  },
                  child: Image.asset(
                    'assets/events_resources/images/${args.eventPictures?[0]}',
                    width: 50,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder:(context) {
                      return EventPicture(image: 'assets/events_resources/images/${args.eventPictures?[1]}',);
                    },);
                  },
                  child: Image.asset(
                    'assets/events_resources/images/${args.eventPictures?[1]}',
                    width: 50,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder:(context) {
                      return EventPicture(image: 'assets/events_resources/images/${args.eventPictures?[2]}',);
                    },);
                  },
                  child: Image.asset(
                    'assets/events_resources/images/${args.eventPictures?[2]}',
                    width: 50,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            Spacer(),
            Text(
              text
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}