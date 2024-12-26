// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class MathGraphWidget extends StatefulWidget {
  const MathGraphWidget({
    super.key,
    this.width,
    this.height,
    required this.graphType,
    required this.xRange,
    required this.lineColor,
    required this.lineThickness,
    required this.showAxisLabels,
    required this.axisLabelFontSize,
    required this.axisLabelColor,
  });

  final double? width;
  final double? height;
  final String graphType;
  final List<double> xRange;
  final Color lineColor;
  final double lineThickness;
  final bool showAxisLabels;
  final double axisLabelFontSize;
  final Color axisLabelColor;

  @override
  State<MathGraphWidget> createState() => _MathGraphWidgetState();
}

class _MathGraphWidgetState extends State<MathGraphWidget> {
  List<FlSpot> _generateGraphData(String type) {
    final List<FlSpot> dataPoints = [];
    for (double x = widget.xRange[0]; x <= widget.xRange[1]; x += 0.1) {
      double y;
      switch (type.toLowerCase()) {
        case 'trigonometric':
          y = sin(x);
          break;
        case 'exponential':
          y = exp(x);
          break;
        case 'quadratic':
          y = pow(x, 2).toDouble();
          break;
        case 'polynomial':
          y = pow(x, 3).toDouble() - 2 * x;
          break;
        default:
          y = 0;
      }
      dataPoints.add(FlSpot(x, y));
    }
    return dataPoints;
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> graphData = _generateGraphData(widget.graphType);

    if (graphData.isEmpty) {
      return Center(
        child: Text(
          'No Data Available',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: graphData,
              isCurved: true,
              barWidth: widget.lineThickness,
              color: widget.lineColor,
              dotData: FlDotData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: widget.showAxisLabels,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: widget.axisLabelColor,
                    fontSize: widget.axisLabelFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: widget.showAxisLabels,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: widget.axisLabelColor,
                    fontSize: widget.axisLabelFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            verticalInterval: 1,
            horizontalInterval: 10,
            getDrawingVerticalLine: (_) =>
                FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
            getDrawingHorizontalLine: (_) =>
                FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
          ),
        ),
      ),
    );
  }
}
