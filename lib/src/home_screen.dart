import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense_tracker/src/complex_ui/custome_drawer/custom_drawer.dart';
import 'package:my_expense_tracker/src/fancy_button/fancy_float_button.dart';
import 'package:my_expense_tracker/src/graph/fl_chart._graph.dart';
import 'package:my_expense_tracker/src/graph/graph_screen.dart';
import 'package:my_expense_tracker/src/screens/add_expense.dart';
import 'package:my_expense_tracker/src/screens/carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> hoverAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(
        reverse: true,
      );
    hoverAnimation = Tween(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.04),
    ).animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SlideTransition(
              position: hoverAnimation,
              child: Image.asset('assets/images/logo_carnival.png'),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(GraphScreen());
                },
                child: Text("Draw Normal Graph")),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(F1Graph());
                },
                child: Text("F1 Charts")),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(CarouselImage());
                },
                child: Text("Carousel Images")),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(CustomDrawer());
                },
                child: Text("Custom Drawer")),
          ],
        ),
      ),
      floatingActionButton: FancyButton(
          titleStr: 'Add Expense',
          colorStr: Colors.amber,
          onPressed: () {
            Get.to(AddExpense());
          }),
    );
  }
}
