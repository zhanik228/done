import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wsk_pro/models/ticket_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketCreate extends StatefulWidget {
  const TicketCreate({super.key});

  @override
  State<TicketCreate> createState() => _TicketCreateState();
}

class _TicketCreateState extends State<TicketCreate> {
  File? _selectedImage;
  String? _selectValue = 'ceremony_closed';
  var controller = TextEditingController();
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
    readFromSp();
  }

  void readFromSp() {
    var ticketsList = _prefs.getStringList('tickets');
    if (ticketsList != null) {
      _tickets = ticketsList.map((e) => TicketModel.fromJson(json.decode(e))).toList();
    }
  }

  void saveIntoSp() {
    List<String> ticketsList = _tickets.map((e) => json.encode(e.toJson())).toList();
    _prefs.setStringList('tickets', ticketsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Create'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Text('Opening Ceremony'),
                  value: 'ceremony_open',
                ),
                DropdownMenuItem(
                  child: Text('Closing Ceremony'),
                  value: 'ceremony_closed',
                ),
              ], 
              onChanged:(value) {
                setState(() {
                  _selectValue = value;
                });
              },
              value: _selectValue,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Your name'
              ),
            ),
            ElevatedButton(
              onPressed:() {
                _selectPicture();
              }, 
              child: Text('Choose a picture'),
            ),
            _selectedImage != null ? Image.file(_selectedImage!) : Text('Please select an image'),
            ElevatedButton(
              onPressed:() {
                var year = DateTime.now().year;
                var month = DateTime.now().month;
                var day = DateTime.now().day;
                var hour = DateTime.now().hour;
                var minute = DateTime.now().minute;
                var time = '${year}-${month}-${day} ${hour}:${minute}';
                var numbers = '1234567890';
                var r = Random();
                var string = String.fromCharCodes(List.generate(10, (index) => r.nextInt(33) + 89));
                var seat = 'A6 Row7 Column9';
                if (_selectedImage != null) {
                  var image = base64Encode(_selectedImage!.readAsBytesSync());
                  _tickets.add(
                    TicketModel(controller.text, time, _selectValue, seat, image)
                  );
                } else {
                  _tickets.add(
                    TicketModel(controller.text, time, _selectValue, seat, '')
                  );
                }
                List<String> jsonList = _tickets.map((e) => jsonEncode(e.toJson())).toList();
                print(jsonList);
                _prefs.setStringList('tickets', jsonList);
                Navigator.pushNamed(context, '/');
              }, 
              child: Text('Create a ticket'),
            )
          ],
        ),
      ),
    );
  }

  Future _selectPicture() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }
}