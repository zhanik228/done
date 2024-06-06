import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wsk_pro/models/event_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  late Future<List<EventModel>> _events;
  late SharedPreferences _prefs;
  FilterType _selectedFilter = FilterType.all;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
    });
    _events = _getEvents();
  }

  Future<List<EventModel>> _getEvents() async {
    var jsondata = await rootBundle.loadString('assets/events_resources/json/events_data.json');
    var list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => EventModel.fromJson(e)).toList();
  }

  void _markAsRead(EventModel event) {
    event.eventReadStatus = true;
    var key = '${event.eventId}_read';
    _prefs.setBool(key, true);
    setState(() {
      
    });
  }

  void _increaseCount(EventModel event) {
    var key = '${event.eventId}_view';
    var value = _prefs.getInt(key) ?? 0;
    _prefs.setInt(key, value+1);
    setState(() {
      
    });
  }

  Widget _getReadStatus(EventModel event) {
    var key = '${event.eventId}_read';
    var isRead = _prefs.getBool(key) ?? false;
    
    if (isRead) {
      event.eventReadStatus = true;
      return Text('Read');
    } else {
      return Text('Unread');
    }
  }

  List<EventModel> _filterEvents(List<EventModel> events) {
    switch (_selectedFilter) {
      case FilterType.all:
        return events;
      case FilterType.read:
        return events.where((element) => element.eventReadStatus == true).toList();
      case FilterType.unread:
        return events.where((element) => element.eventReadStatus == false).toList();
    }
  }

  Widget _getFilterBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed:() {
            setState(() {
              _selectedFilter = FilterType.all;
            });
          }, 
          child: const Text('All')
        ),
        Text(' / '),
        TextButton(
          onPressed:() {
            setState(() {
              _selectedFilter = FilterType.read;
            });
          }, 
          child: const Text('Read')
        ),
        Text(' / '),
        TextButton(
          onPressed:() {
            setState(() {
              _selectedFilter = FilterType.unread;
            });
          }, 
          child: const Text('Unread')
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Events List'),
        ),
      ),
      body: Column(
        children: [
          _getFilterBtns(),
          FutureBuilder(
            future: _events, 
            builder:(context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }

              if (snapshot.hasData) {
                List<EventModel> data = snapshot.data as List<EventModel>;
                List<EventModel> filteredData = _filterEvents(data);

                return Expanded(
                  child: ListView
                    .builder(
                      itemCount: filteredData.length,
                      itemBuilder:(context, index) {
                        var title = '${filteredData[index].eventTitle}';
                        var text = '${filteredData[index].eventText}';
                        var imagePath = 'assets/events_resources/images/${filteredData[index].eventPictures?[0]}';
                  
                        return Card(
                          child: ListTile(
                            leading: Image.asset(imagePath),
                            title: Column(
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  text,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                _getReadStatus(filteredData[index]),
                              ],
                            ),
                            onTap: () {
                              _markAsRead(filteredData[index]);
                              _increaseCount(filteredData[index]);
                              Navigator.pushNamed(context, '/eventDetails', arguments: filteredData[index]);
                            },
                          ),
                        );
                      },
                    ),
                );
              }

              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}

enum FilterType {
  all,
  read,
  unread,
}