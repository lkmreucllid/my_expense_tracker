import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final bool selected;
  final GestureTapCallback callback;
  const RoundedButton(
      {Key? key,
      required this.title,
      this.selected = false,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backGroundColor = selected ? Colors.white : Colors.transparent;
    Color textColor = selected ? Colors.red : Colors.white;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: new InkWell(
          onTap: callback,
          child: new Container(
            height: 36.0,
            decoration: new BoxDecoration(
              color: backGroundColor,
              border: new Border.all(color: Colors.white, width: 1.0),
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
