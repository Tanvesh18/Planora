import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Piechart extends StatelessWidget {
  final int inProgress;
  final int toggleTaskOnHold;
  final int completed;
  final int totalTasks;

  const Piechart({
    super.key,
    required this.inProgress,
    required this.completed,
    required this.totalTasks, 
    required this.toggleTaskOnHold,
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
                title: '$inProgress\nIn Progress',
                titleStyle: TextStyle(color: Colors.white, fontSize: 12),
              ),
              PieChartSectionData(
                value: completed.toDouble(),
                radius: 50,
                color: Colors.green,
                title: '$completed\nCompleted',
                titleStyle: TextStyle(color: Colors.white, fontSize: 12),
              ),
              PieChartSectionData(
                value: totalTasks.toDouble(),
                radius: 50,
                color: Colors.purple,
                title: '$totalTasks\nTotal Tasks',
                titleStyle: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
