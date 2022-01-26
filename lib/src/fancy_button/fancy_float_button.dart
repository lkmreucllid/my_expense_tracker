import 'package:flutter/material.dart';

class FancyButton extends StatelessWidget {
  FancyButton({
    required this.onPressed,
    required this.titleStr,
    required this.colorStr,
  });

  final GestureTapCallback onPressed;
  final String titleStr;
  final Color colorStr;

  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.deepOrange,
      splashColor: Colors.orange,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.explore,
                color: colorStr,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              titleStr,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
