import 'package:flutter/material.dart';

class EventPicture extends StatelessWidget {
  EventPicture({super.key, this.image});
  String? image;

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: Image.asset(
        '${image}',
        width: 500,
        height: 500,
      ),
    );
  }
}