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

import 'dart:math';

class DataAnalyse extends StatefulWidget {
  const DataAnalyse({
    super.key,
    this.width,
    this.height,
    required this.xInput,
    required this.yInput,
    required this.type,
  });

  final double? width;
  final double? height;
  final String xInput;
  final String yInput;
  final String type;

  @override
  State<DataAnalyse> createState() => _DataAnalyseState();
}

class _DataAnalyseState extends State<DataAnalyse> {
  late Map<String, Map<String, dynamic>> results;

  @override
  void initState() {
    super.initState();
    results = analyze(widget.xInput, widget.yInput, widget.type);
  }

  @override
  void didUpdateWidget(covariant DataAnalyse oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if any relevant property has changed
    if (oldWidget.xInput != widget.xInput ||
        oldWidget.yInput != widget.yInput ||
        oldWidget.type != widget.type) {
      setState(() {
        // Recalculate results based on the new inputs
        results = analyze(widget.xInput, widget.yInput, widget.type);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDarkMode
        ? FlutterFlowTheme.of(context).secondaryBackground
        : FlutterFlowTheme.of(context).primaryBackground;
    final textColor = isDarkMode
        ? FlutterFlowTheme.of(context).secondaryText
        : FlutterFlowTheme.of(context).primaryText;

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analysis Results (${widget.type})',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final entry = results.entries.elementAt(index);
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  color: isDarkMode
                      ? FlutterFlowTheme.of(context).secondaryBackground
                      : FlutterFlowTheme.of(context).primaryBackground,
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(
                      entry.value['icon'] as IconData,
                      color: isDarkMode
                          ? FlutterFlowTheme.of(context).primary
                          : Colors.blueAccent,
                    ),
                    title: Text(
                      entry.key,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      entry.value['value'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, Map<String, dynamic>> analyze(
      String xInput, String yInput, String type) {
    try {
      Map<String, Map<String, dynamic>> results = {};

      if (type.toLowerCase() == 'math') {
        results = _analyzeMath(xInput);
      } else {
        results = _analyzeData(xInput, yInput, type);
      }

      return results;
    } catch (e) {
      return {
        'Error': {'value': e.toString(), 'icon': Icons.error_outline}
      };
    }
  }

  Map<String, Map<String, dynamic>> _analyzeMath(String equation) {
    try {
      Map<String, Map<String, dynamic>> mathResults = {
        'Equation': {
          'value': equation,
          'icon': Icons.functions,
        },
        'Domain': {
          'value': 'x ∈ ℝ',
          'icon': Icons.view_module,
        },
        'Range': {
          'value': 'Depends on the equation',
          'icon': Icons.timeline,
        },
        'Intersections': {
          'value': _findIntersections(equation),
          'icon': Icons.add_location_alt,
        },
        'Extrema (Min/Max)': {
          'value': _findExtrema(equation),
          'icon': Icons.trending_up,
        },
        'Symmetry': {
          'value': _determineSymmetry(equation),
          'icon': Icons.compare_arrows,
        },
      };

      return mathResults;
    } catch (e) {
      return {
        'Error': {
          'value': 'Failed to analyze math equation: ${e.toString()}',
          'icon': Icons.error_outline
        }
      };
    }
  }

  Map<String, Map<String, dynamic>> _analyzeData(
      String x, String y, String type) {
    Map<String, Map<String, dynamic>> results = {};
    List<String> xLabels = x.split(',').map((e) => e.trim()).toList();
    List<double> yValues = y
        .split(',')
        .map((e) => double.tryParse(e.trim()))
        .where((v) => v != null)
        .cast<double>()
        .toList();

    if (xLabels.isEmpty || yValues.isEmpty) {
      return {
        'Error': {
          'value': 'Both xInput (labels) and yInput (values) must be valid.',
          'icon': Icons.error_outline
        }
      };
    }

    if (xLabels.length != yValues.length) {
      return {
        'Error': {
          'value': 'Mismatch between the number of labels and values.',
          'icon': Icons.error_outline
        }
      };
    }

    switch (type.toLowerCase()) {
      case 'pie':
        results['Percentage Distribution'] = {
          'value': _percentageDistribution(xLabels, yValues),
          'icon': Icons.pie_chart,
        };
        results['Dominant Category'] = {
          'value': xLabels[yValues.indexOf(_max(yValues))],
          'icon': Icons.star,
        };
        break;

      case 'bar':
        results['Sum'] = {'value': _sum(yValues).toString(), 'icon': Icons.add};
        results['Min Value'] = {
          'value': _min(yValues).toString(),
          'icon': Icons.arrow_downward
        };
        results['Max Value'] = {
          'value': _max(yValues).toString(),
          'icon': Icons.arrow_upward
        };
        results['Range'] = {
          'value': _range(yValues).toString(),
          'icon': Icons.swap_horiz
        };
        results['Category with Max Value'] = {
          'value': xLabels[yValues.indexOf(_max(yValues))],
          'icon': Icons.label,
        };
        break;

      case 'line':
        results['Trend'] = {
          'value': _trendAnalysis(yValues),
          'icon': Icons.trending_up
        };
        results['Mean'] = {
          'value': _mean(yValues).toString(),
          'icon': Icons.calculate
        };
        results['Median'] = {
          'value': _median(yValues).toString(),
          'icon': Icons.linear_scale
        };
        results['Standard Deviation'] = {
          'value': _standardDeviation(yValues).toString(),
          'icon': Icons.stacked_line_chart
        };
        break;

      case 'scatter':
        results['Correlation'] = {
          'value': _correlation(yValues).toString(),
          'icon': Icons.scatter_plot
        };
        results['Data Spread (Std Dev)'] = {
          'value': _standardDeviation(yValues).toString(),
          'icon': Icons.bar_chart,
        };
        break;

      case 'mathematical':
        results['Sum'] = {'value': _sum(yValues).toString(), 'icon': Icons.add};
        results['Mean'] = {
          'value': _mean(yValues).toString(),
          'icon': Icons.calculate
        };
        results['Median'] = {
          'value': _median(yValues).toString(),
          'icon': Icons.linear_scale
        };
        results['Standard Deviation'] = {
          'value': _standardDeviation(yValues).toString(),
          'icon': Icons.stacked_line_chart,
        };
        results['Variance'] = {
          'value': (_standardDeviation(yValues) * _standardDeviation(yValues))
              .toString(),
          'icon': Icons.functions,
        };
        break;

      default:
        results['Error'] = {
          'value':
              'Unsupported chart type. Use pie, bar, line, scatter, or mathematical.',
          'icon': Icons.error_outline,
        };
    }

    return results;
  }

  String _findIntersections(String equation) {
    // Placeholder logic for finding intersections
    if (equation.contains('x')) {
      return 'Intersections with x-axis: Solved from y = 0';
    }
    return 'No intersections';
  }

  String _findExtrema(String equation) {
    // Placeholder logic for extrema
    return 'Calculated from derivative: Critical points';
  }

  String _determineSymmetry(String equation) {
    if (equation.contains('x^2') || equation.contains('x*x')) {
      return 'Even function';
    } else if (equation.contains('-x')) {
      return 'Odd function';
    } else {
      return 'Neither even nor odd';
    }
  }

  String _percentageDistribution(List<String> labels, List<double> values) {
    double total = values.reduce((a, b) => a + b);
    return List.generate(
      labels.length,
      (i) => '${labels[i]}: ${(values[i] / total * 100).toStringAsFixed(2)}%',
    ).join(', ');
  }

  double _mean(List<double> values) =>
      values.reduce((a, b) => a + b) / values.length;

  double _median(List<double> values) {
    values.sort();
    int middle = values.length ~/ 2;
    return values.length % 2 == 1
        ? values[middle]
        : (values[middle - 1] + values[middle]) / 2.0;
  }

  double _sum(List<double> values) => values.reduce((a, b) => a + b);

  double _min(List<double> values) => values.reduce((a, b) => a < b ? a : b);

  double _max(List<double> values) => values.reduce((a, b) => a > b ? a : b);

  double _range(List<double> values) => _max(values) - _min(values);

  String _trendAnalysis(List<double> values) {
    double diffSum = 0;
    for (int i = 1; i < values.length; i++) {
      diffSum += values[i] - values[i - 1];
    }
    return diffSum > 0
        ? 'Increasing'
        : diffSum < 0
            ? 'Decreasing'
            : 'Stable';
  }

  double _standardDeviation(List<double> values) {
    double mean = _mean(values);
    double variance = values
            .map((value) => (value - mean) * (value - mean))
            .reduce((a, b) => a + b) /
        values.length;
    return sqrt(variance);
  }

  double _correlation(List<double> values) {
    return 0.0; // Placeholder logic for correlation
  }
}
