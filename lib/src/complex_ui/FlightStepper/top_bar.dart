import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final double height;
  const TopBar({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.red, const Color(0xFFE64C85)],
            ),
          ),
        ),
        new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: new Text(
            'FlightSearch',
            style: TextStyle(
                fontFamily: 'NothingYouCouldDo', fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
