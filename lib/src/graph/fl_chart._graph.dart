import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class F1Graph extends StatelessWidget {
  // Generate some dummy data for the cahrt

  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  final List<FlSpot> dummyDataActual = [
    FlSpot(1.0, (68000).toDouble()),
    FlSpot(2.0, (98000).toDouble()),
    FlSpot(3.0, (88000).toDouble()),
    FlSpot(4.0, (58000).toDouble()),
    FlSpot(5.0, (48000).toDouble()),
    FlSpot(6.0, (88000).toDouble()),
    FlSpot(7.0, (38000).toDouble()),
    FlSpot(8.0, (78000).toDouble()),
    FlSpot(9.0, (78000).toDouble()),
    FlSpot(10.0, (3500).toDouble()),
    FlSpot(11.0, (1800).toDouble()),
    FlSpot(12.0, (78000).toDouble()),
    FlSpot(13.0, (78000).toDouble()),
    FlSpot(14.0, (78000).toDouble()),
    FlSpot(15.0, (240000).toDouble()),
    FlSpot(16.0, (78000).toDouble()),
    FlSpot(17.0, (78000).toDouble()),
    FlSpot(18.0, (78000).toDouble()),
    FlSpot(19.0, (25124).toDouble()),
    FlSpot(20.0, (78000).toDouble()),
    FlSpot(21.0, (78000).toDouble()),
    FlSpot(22.0, (457).toDouble()),
    FlSpot(23.0, (78000).toDouble()),
    FlSpot(24.0, (6524).toDouble()),
    FlSpot(25.0, (78000).toDouble()),
    FlSpot(26.0, (78000).toDouble()),
    FlSpot(27.0, (78000).toDouble()),
    FlSpot(28.0, (8457).toDouble()),
    FlSpot(29.0, (78000).toDouble()),
    FlSpot(30.0, (78000).toDouble()),
  ];
  final List<String> months = [
    "",
    "Jan 2020",
    "Feb 2020",
    "Mar 2020",
    "Apr 2020",
    "May 2020",
    "Jun 2020",
    "July 2020",
    "Aug 2020",
    "Sep 2020",
    "Oct 2020",
    "Nov 2020",
    "Dec 2020",
    "Jan 2021",
    "Feb 2021",
    "Mar 2021",
    "Apr 2021",
    "May 2021",
    "Jun 2021",
    "July 2021",
    "Aug 2021",
    "Sep 2021",
    "Oct 2021",
    "Nov 2021",
    "Dec 2021",
    "Jan 2022",
    "Feb 2022",
    "Mar 2022",
    "Apr 2022",
    "May 2022",
    "Jun 2022",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.6,
                width: Get.width,
                padding: EdgeInsets.all(20),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(enabled: true),
                    //minY: 0.0,
                    // maxY: 150000,
                    borderData: FlBorderData(show: true),
                    titlesData: FlTitlesData(
                      bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 5,
                          // textStyle: yearTextStyle,
                          getTitles: (value) {
                            return months[value.toInt()];
                          }),
                      topTitles: SideTitles(
                        showTitles: false,
                      ),
                      //rightTitles: SideTitles(
                      // showTitles: true,
                      // getTitles: (value) {
                      //   return '\$ ${value + 100}';
                      // },
                      //  ),
                    ),
                    axisTitleData: FlAxisTitleData(
                        leftTitle: AxisTitle(
                            showTitle: true, titleText: 'Rupees', margin: 10),
                        bottomTitle: AxisTitle(
                            showTitle: true,
                            margin: 15,
                            titleText: 'Month',
                            textAlign: TextAlign.center)),
                    gridData: FlGridData(
                      show: true,
                      checkToShowHorizontalLine: (double value) {
                        return true;
                      },
                      checkToShowVerticalLine: (double value) {
                        return false;
                      },
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: dummyDataActual,
                        isCurved: false,
                        barWidth: 3,
                        colors: [
                          Colors.blue,
                        ],
                        //to Show red zone after cutOff value
                        belowBarData: BarAreaData(
                          show: true,
                          colors: [Colors.red.withOpacity(0.5)],
                          cutOffY: 75000.toDouble(),
                          applyCutOffY: true,
                        ),
                        //to show color above graph line for safe zone.
                        // aboveBarData: BarAreaData(
                        //   show: true,
                        //   colors: [Colors.lightGreen.withOpacity(0.5)],
                        //   cutOffY: 75000.toDouble(),
                        //   applyCutOffY: true,
                        // ),
                        //to Show dots for values
                        dotData: FlDotData(
                          show: true,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
