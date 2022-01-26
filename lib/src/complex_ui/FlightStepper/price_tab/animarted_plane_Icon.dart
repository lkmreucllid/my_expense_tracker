import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedPlaneIcon extends AnimatedWidget {
  AnimatedPlaneIcon({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = super.listenable as Animation<double>;
    return Icon(
      Icons.airplanemode_active,
      color: Colors.red,
      size: animation.value,
    );
  }
}
