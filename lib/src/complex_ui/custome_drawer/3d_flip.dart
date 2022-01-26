import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:my_expense_tracker/src/complex_ui/FlightStepper/FlightStepper.dart';
import 'package:my_expense_tracker/src/complex_ui/sys_expedition_travel/main_page.dart';

class Flip3D extends StatefulWidget {
  const Flip3D({Key? key}) : super(key: key);

  @override
  _Flip3DState createState() => _Flip3DState();
}

class _Flip3DState extends State<Flip3D> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  static const double maxSlide = 300.0;
  bool _canBeDragged = false;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragOpenFromRight = animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragOpenFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = (details.primaryDelta! / maxSlide);
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    var myChild = Container(
      color: Colors.blue,
    );
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.translucent,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          // double slide = maxSlide * animationController.value;
          // double scale = 1 - (animationController.value * 0.4);
          return Material(
            color: Colors.blueGrey,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(maxSlide * (animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: MyDrawer(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: myChild,
                  ),
                ),
                Positioned(
                  top: 4.0 + MediaQuery.of(context).padding.top,
                  left: 4.0 + animationController.value * maxSlide,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: toggle,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 16.0 + MediaQuery.of(context).padding.top,
                  left: animationController.value *
                      MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Hello Flutter Europe',
                    // style: Theme.of(context).primaryTextTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      height: double.infinity,
      child: Material(
        color: Colors.blueAccent,
        child: SafeArea(
          child: Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                  onTap: () => Get.to(Flip3D()),
                  leading: Icon(Icons.new_releases),
                  title: Text('3D Flip'),
                ),
                ListTile(
                  onTap: () => Get.to(FlightStepper()),
                  leading: Icon(Icons.new_releases),
                  title: Text('Flight Search'),
                ),
                ListTile(
                  onTap: () => Get.to(MainTravelPage()),
                  leading: Icon(Icons.new_releases),
                  title: Text('Travel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
