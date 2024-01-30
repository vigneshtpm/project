import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Time extends StatelessWidget {
  double percent = 0.7;
  bool isRunning = false;
  int duration = 30; // in seconds

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 13.0,
          animation: true,
          percent: percent,
          center: Text(
            "${(percent * 100).toStringAsFixed(1)}%",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          footer: Text(
            "Sales this week",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.purple,
        ),
      ),
    );
  }
}
