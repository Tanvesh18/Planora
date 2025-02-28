import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Piechart extends StatelessWidget {
  final int inProgress;
  final int onHold;
  final int completed;

  const Piechart({
    super.key,
    required this.inProgress,
    required this.onHold,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [ 
        Text(
          "OVERVIEW",
          style: TextStyle(
            fontFamily: 'Impact',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        PieChart(
          swapAnimationDuration: const Duration(milliseconds: 750),
          swapAnimationCurve: Curves.easeInOutQuint,
          PieChartData(
            sections: [
              PieChartSectionData(
                value: inProgress.toDouble(),
                radius: 50,
                color: Colors.blue,
              ),
              PieChartSectionData(
                value: onHold.toDouble(),
                radius: 50,
                color: Colors.yellow,
              ),
              PieChartSectionData(
                value: completed.toDouble(),
                radius: 50,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
