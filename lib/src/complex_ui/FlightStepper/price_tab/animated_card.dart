import 'package:flutter/material.dart';

class AnimatedCard extends AnimatedWidget {
  final bool isLeft;
  static const double height = 80.0;
  static const double width = 140.0;
  AnimatedCard(
      {Key? key, required Animation<double> animation, required this.isLeft})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = super.listenable as Animation<double>;
    return Positioned(
      top: animation.value,
      right: !isLeft ? 650.0 : 0.0,
      left: isLeft ? 650.0 : 0.0,
      child: Container(
        height: height,
        width: width,
        color: Colors.grey.withOpacity(0.2),
        child: Text("Hello, Peter"),
      ),
    );
  }
}
