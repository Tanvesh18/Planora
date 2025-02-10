import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Piechart extends StatelessWidget {
  const Piechart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [ 
        Text("OVERVIEW",
        style: TextStyle(
          fontFamily: 'Impact',
          fontSize: 20,
          color: Colors.white
        ),
        ),
        PieChart(
        swapAnimationDuration: const Duration(milliseconds: 750),
        swapAnimationCurve: Curves.easeInOutQuint,
        PieChartData(
          sections: [
            PieChartSectionData(
              value: 20,
              radius: 50,
              color: Colors.blue,
            ),
            PieChartSectionData(
              value: 20,
              radius: 50,
              color: Colors.purple,
            ),
            PieChartSectionData(
              value: 60,
              radius: 50,
              color: Colors.yellow,
            ),
            PieChartSectionData(
              value: 40,
              radius: 50,
              color: Colors.green,
            ),
          ],
        ),
      ),
      ]
    );
  }
}