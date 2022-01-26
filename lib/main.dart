import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_expense_tracker/src/complex_ui/sys_expedition_travel/styles.dart';
import 'package:my_expense_tracker/src/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Carnival',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: mainBlack,
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
