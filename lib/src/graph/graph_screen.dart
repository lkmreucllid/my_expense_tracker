import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final List<Feature> features = [
    Feature(
      data: [
        78951 / 100000,
        56245 / 100000,
        84524 / 100000,
        95684 / 100000,
        84521 / 100000,
        35484 / 100000
      ],
      color: Colors.amber,
      title: 'Flutter',
    ),
    /*Feature(
      data: [
        85412 / 100000,
        95684 / 100000,
        78457 / 100000,
        58424 / 100000,
        98562 / 100000,
        14521 / 100000
      ],
      color: Colors.green,
      title: 'Android',
    ),
    Feature(
      data: [
        57841 / 100000,
        65842 / 100000,
        98541 / 100000,
        45214 / 100000,
        24512 / 100000,
        36521 / 100000
      ],
      color: Colors.red,
      title: 'Swift',
    ),
    Feature(
      data: [
        65242 / 100000,
        45842 / 100000,
        52452 / 100000,
        45123 / 100000,
        45745 / 100000,
        24512 / 100000
      ],
      color: Colors.blue,
      title: 'Kotlin',
    ),*/
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 64.0),
          child: Text(
            "Credit Card Expenses",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        LineGraph(
          features: features,
          size: Size(450, 450),
          labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6'],
          labelY: ['25000', '45000', '65000', '75000', '85000', '100000'],
          showDescription: true,
          graphColor: Colors.black87,
          graphOpacity: 0.0,
        ),
      ],
    );
  }
}
