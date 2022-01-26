import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense_tracker/src/complex_ui/FlightStepper/FlightStepper.dart';
import 'package:my_expense_tracker/src/complex_ui/custome_drawer/3d_flip.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  static const double maxSlide = 325.0;
  bool _canBeDragged = false;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    super.initState();
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
      color: Colors.yellow,
    );
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          double slide = maxSlide * animationController.value;
          double scale = 1 - (animationController.value * 0.4);
          return Stack(
            children: [
              MyDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..scale(scale)
                  ..translate(slide),
                alignment: Alignment.centerLeft,
                child: myChild,
              ),
            ],
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
    return Material(
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
                leading: Icon(Icons.new_releases),
                title: Text('Flight Search'),
                onTap: () => Get.to(FlightStepper()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
