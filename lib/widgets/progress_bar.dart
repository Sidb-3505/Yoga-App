import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  final double percent;
  const ProgressBar({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: 250,
      percent: percent.clamp(0.0, 1.0),
      backgroundColor: Colors.grey.shade300,
      progressColor: Colors.blueAccent,
      lineHeight: 8,
      animation: true,
    );
  }
}
