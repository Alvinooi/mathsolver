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
import 'package:graph_calculator/graph_calculator.dart';
import 'dart:math' as math;
import 'package:expressions/expressions.dart';
import 'package:math_expressions/math_expressions.dart' as math_exp;
import 'dart:async';
import 'package:widgets_to_png/widgets_to_png.dart';
import 'package:widgets_to_png/src/entity/image_converter.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io' show Platform, File;
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:davinci/davinci.dart';
import 'dart:io'; // To detect if running on desktop

// Function to generate color variants based on a given scheme.
Color generateColorVariant(String scheme, int index, int totalItems) {
  if (totalItems == 0) return Colors.grey;

  final schemes = {
    'cb': [
      // Classic Blue
      Color(0xFF0D47A1), // Deep Royal Blue
      Color(0xFF1976D2), // Strong Blue
      Color(0xFF42A5F5), // Vibrant Sky Blue
      Color(0xFF64B5F6), // Bright Aqua Blue
      Color(0xFF90CAF9) // Light Blue
    ],
    'ng': [
      // Natural Green
      Color(0xFF2E7D32), // Deep Forest Green
      Color(0xFF8BC34A), // Vibrant Grass Green
      Color(0xFFFFD54F), // Soft Yellow
      Color(0xFFA1887F), // Earthy Brown
      Color(0xFF4CAF50) // Fresh Green
    ],
    'cg': [
      // Cool Gray
      Color(0xFF37474F), // Dark Cool Gray
      Color(0xFF546E7A), // Blueish Gray
      Color(0xFF78909C), // Soft Cool Gray
      Color(0xFFB0BEC5), // Light Cool Gray
      Color(0xFFECEFF1) // Very Light Gray
    ],
    'ob': [
      // Ocean Breeze
      Color(0xFF006064), // Deep Ocean Blue
      Color(0xFF00838F), // Tropical Teal
      Color(0xFF4FC3F7), // Bright Aqua
      Color(0xFF80DEEA), // Light Turquoise
      Color(0xFFB2EBF2) // Soft Aqua
    ],
    'dn': [
      // Dark Neon
      Color(0xFFAD1457), // Dark Neon Pink
      Color(0xFF6A1B9A), // Neon Purple
      Color(0xFF4527A0), // Electric Indigo
      Color(0xFF283593), // Vibrant Blue
      Color(0xFF1DE9B6) // Bright Neon Green
    ],
    'pr': [
      // Pastel Rainbow
      Color(0xFFF48FB1), // Pastel Pink
      Color(0xFFD1C4E9), // Soft Purple
      Color(0xFFCE93D8), // Light Lavender
      Color(0xFFB3E5FC), // Soft Blue
      Color(0xFFFFF59D) // Soft Yellow
    ],
  };

  List<Color> chosenScheme = schemes[scheme] ?? [Colors.grey];
  return chosenScheme[index % chosenScheme.length];
}

class ChartDisplayWidget extends StatefulWidget {
  const ChartDisplayWidget({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.scheme,
    required this.lineThickness,
    required this.dataPointSize,
    required this.chartType,
    required this.showDataPoints,
    required this.showGridLines,
    required this.showAxisLabels,
    required this.showLegend,
    required this.explodeSlices,
    required this.titleFontSize,
    required this.axisLabelFontSize,
    required this.legendFontSize,
    this.xInput,
    this.yInput,
    required this.mode,
  });

  final double? width;
  final double? height;
  final String title;
  final String scheme;
  final double lineThickness;
  final double dataPointSize;
  final String chartType;
  final bool showDataPoints;
  final bool showGridLines;
  final bool showAxisLabels;
  final bool showLegend;
  final bool explodeSlices;
  final double titleFontSize;
  final double axisLabelFontSize;
  final double legendFontSize;
  final String? xInput;
  final String? yInput;
  final bool mode;

  @override
  State<ChartDisplayWidget> createState() => _ChartDisplayWidgetState();
}

class _ChartDisplayWidgetState extends State<ChartDisplayWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  int? touchedIndex;
  var graphController;
  Offset initialFocusPoint = Offset.zero;
  Offset dragStart = Offset.zero;
  Offset temporaryDragOffset = Offset.zero;
  Timer? _throttleTimer;
  List<FlSpot> flChartData = [];
  String debugInfo = '';
  GlobalKey? _globalKey;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController?.forward();

    flChartData = _parseInputData(widget.xInput, widget.yInput);
    // Initialize Graph with configuration
    Graph graph = Graph(
      gridStep: widget.dataPointSize,
      backgroundColor: widget.mode ? Colors.black : Colors.white,
      axesColor: widget.showAxisLabels ? Colors.white : Colors.transparent,
      gridColor: widget.showGridLines ? Colors.grey : Colors.transparent,
      gridWidth: 1.0,
      axesWidth: widget.lineThickness * 5,
      drawAxes: widget.showAxisLabels,
      numbersStyle: TextStyle(
        color: widget.showAxisLabels ? Colors.white : Colors.transparent,
      ),
    );

    _addFunctionToGraph();
  }

  @override
  void didUpdateWidget(covariant ChartDisplayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.xInput != widget.xInput ||
        oldWidget.yInput != widget.yInput ||
        oldWidget.chartType != widget.chartType) {
      setState(() {
        debugInfo = 'Updating inputs:\n'
            'xInput: ${widget.xInput}\n'
            'yInput: ${widget.yInput}\n'
            'type: ${widget.chartType}\n';
      });

      if (widget.chartType.toLowerCase() == 'math') {
        _addFunctionToGraph();
        setState(() {
          debugInfo = ''; // Clear debug info after successful update
        });
      } else {
        flChartData = _parseInputData(widget.xInput, widget.yInput);
        if (flChartData.isEmpty) {
          setState(() {
            debugInfo += 'Parsed data is empty. Please check your inputs.\n';
          });
        } else {
          setState(() {
            debugInfo = ''; // Clear debug info after successful update
          });
        }
      }
    }
  }

  Widget _buildGraphContent() {
    if (widget.chartType.toLowerCase() == 'math') {
      _addFunctionToGraph();
      return GraphWidget(
        graphController: graphController,
        size: Size(widget.width ?? double.infinity, widget.height ?? 400.0),
      );
    } else {
      return _buildStatisticalChart(flChartData, Colors.black);
    }
  }

  void _addFunctionToGraph() {
    if (widget.chartType.toLowerCase() != 'math') {
      return; // Only apply for math graph
    }

    if (widget.xInput != null) {
      try {
        String formattedEquation = _formatEquation(widget.xInput!);
        debugPrint("Adding formatted function: $formattedEquation");
        // Initialize GraphController
        graphController = GraphController(
            graph: Graph(
                gridStep: 100,
                numbersStyle: const TextStyle(color: Colors.black)));

        graphController.addFunction(GraphFunction(
          function: (x) {
            String equationWithX = formattedEquation.replaceAll('x', '($x)');
            try {
              return _evaluateExpression(equationWithX);
            } catch (e) {
              debugPrint("Error evaluating equation with x=$x: $e");
              return 0.0;
            }
          },
          color: Colors.red, // Bright color for visibility
        ));

        graphController.update(); // Refresh the graph
      } catch (e) {
        debugPrint("Error adding function: $e");
      }
    }
  }

  String _formatEquation(String equation) {
    try {
      String formattedEquation = equation;

      // Handle exponent formatting: replace `x^2` with `(x*x)`
      formattedEquation = formattedEquation.replaceAllMapped(
        RegExp(r'([a-zA-Z])\^(\d+)'),
        (match) {
          String base = match.group(1)!;
          int exponent = int.parse(match.group(2)!);
          return '(' + List.filled(exponent, base).join('*') + ')';
        },
      );

      // Insert explicit multiplication for implicit multiplication, e.g., `2x` becomes `2*x`
      formattedEquation = formattedEquation.replaceAllMapped(
        RegExp(r'(\d)([a-zA-Z])'),
        (match) => '${match.group(1)}*${match.group(2)}',
      );

      // Format expressions like `2(x + 3)` to `2*(x + 3)`
      formattedEquation = formattedEquation.replaceAllMapped(
        RegExp(r'(\d)\('),
        (match) => '${match.group(1)}*(',
      );

      // Wrap 'x' with parentheses where appropriate
      formattedEquation = formattedEquation.replaceAllMapped(
        RegExp(r'\bx\b'),
        (match) => '(x)',
      );

      // Handle implicit multiplication between parentheses, e.g., `(x+2)(x-3)` becomes `(x+2)*(x-3)`
      formattedEquation = formattedEquation.replaceAllMapped(
        RegExp(r'\)\('),
        (match) => ')*(',
      );

      print("Original equation: $equation");
      print("Formatted equation: $formattedEquation");
      return formattedEquation;
    } catch (e) {
      print("Error formatting equation: $e");
      return ''; // Return an empty string if there's an error
    }
  }

  /// Formats the equation by replacing common syntax (e.g., '^' for power).
  double _evaluateExpression(String equation) {
    try {
      // This uses basic parsing for evaluation, for simple expressions
      // For complex expressions, consider using an expression evaluator library.
      final expression = Expression.parse(equation);
      final evaluator = const ExpressionEvaluator();

      // Specify the map type explicitly as <String, dynamic>
      final Map<String, dynamic> context = {};

      final result = evaluator.eval(expression, context);
      if (result is double || result is int) {
        return result.toDouble();
      } else {
        debugPrint("Unexpected result type: $result");
        return 0.0;
      }
    } catch (e) {
      debugPrint("Error evaluating expression: $e");
      return 0.0; // Fallback value
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    Color textColor = isDarkMode ? Colors.white : Colors.black;

    // Title updated directly from widget.title
    String graphTitle =
        widget.title.isNotEmpty ? widget.title : 'Untitled Graph';

    // Chart content rendering
    Widget chart;
    if (widget.chartType.toLowerCase() == 'math') {
      chart = Stack(
        children: [
          GestureDetector(
            onPanStart: (details) {
              initialFocusPoint = graphController.graph.focusPoint;
              dragStart = details.localPosition;
            },
            onPanUpdate: (details) {
              final Offset dragOffset = details.localPosition - dragStart;
              setState(() {
                temporaryDragOffset = dragOffset;
              });

              if (_throttleTimer?.isActive ?? false) return;

              _throttleTimer = Timer(const Duration(milliseconds: 16), () {
                setState(() {
                  graphController.graph.focusPoint =
                      initialFocusPoint - dragOffset;
                  graphController.update();
                });
              });
            },
            onPanEnd: (details) {
              setState(() {
                graphController.graph.focusPoint =
                    initialFocusPoint - temporaryDragOffset;
                temporaryDragOffset = Offset.zero;
                graphController.update();
              });
            },
            child: Transform.translate(
              offset: temporaryDragOffset,
              child: GraphWidget(
                graphController: graphController,
                size: Size(
                    widget.width ?? double.infinity, widget.height ?? 400.0),
              ),
            ),
          ),
        ],
      );
    } else {
      chart = _buildStatisticalChart(flChartData, textColor);
    }

    return Scaffold(
      body: Center(
        child: Davinci(
          builder: (key) {
            _globalKey = key;
            return Container(
              width: widget.width ?? double.infinity,
              height: widget.height ?? 400.0,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.black54
                        : Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Immediate title updates
                  Text(
                    graphTitle,
                    style: TextStyle(
                      fontSize: widget.titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Expanded(child: chart),
                  Text(
                    debugInfo,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          if (widget.chartType.toLowerCase() == 'math') ...[
            Positioned(
              bottom: 80,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    graphController.backToHome();
                  });
                },
                child: const Icon(Icons.center_focus_strong),
                mini: true,
              ),
            )
          ],
          Positioned(
            bottom: 150,
            right: 16,
            child: FloatingActionButton(
              onPressed: () async {
                try {
                  await DavinciCapture.click(
                    context: context,
                    _globalKey!,
                    pixelRatio: 3,
                    saveToDevice: true,
                    albumName: "Charts",
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Chart saved successfully!")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to save chart: $e")),
                  );
                }
              },
              child: const Icon(Icons.save),
            ),
          ),
        ],
      ),
    );
  }

  // Parses input data for statistical charts
  List<FlSpot> _parseInputData(String? xInput, String? yInput) {
    if (widget.chartType.toLowerCase() == 'math') {
      // For math graph, input data parsing is irrelevant
      return [];
    }

    if (xInput == null || yInput == null || xInput.isEmpty || yInput.isEmpty) {
      debugInfo += '\nError: xInput or yInput is null or empty.';
      return [];
    }

    final xValues = xInput.split(',').map((e) => e.trim()).toList();
    final yValues =
        yInput.split(',').map((e) => double.tryParse(e.trim())).toList();

    if (xValues.length != yValues.length) {
      debugInfo +=
          '\nError: Mismatched lengths: ${xValues.length} (x) vs ${yValues.length} (y)';
      return [];
    }

    final validData = <FlSpot>[];
    for (int i = 0; i < yValues.length; i++) {
      final y = yValues[i];
      if (y != null) {
        validData.add(FlSpot(i.toDouble(), y)); // Use index as X value
      } else {
        debugInfo += '\nWarning: Invalid Y value at index $i.';
      }
    }

    if (validData.isEmpty) {
      debugInfo += '\nError: No valid data points parsed.';
    }
    return validData;
  }

  Widget _buildStatisticalChart(List<FlSpot> flChartData, Color textColor) {
    switch (widget.chartType.toLowerCase()) {
      case 'line':
        return _buildLineChart(flChartData, textColor);
      case 'bar':
        return _buildBarChart(flChartData, textColor);
      case 'scatter':
        return _buildScatterChart(flChartData, textColor);
      case 'pie':
        return _buildPieChart(flChartData, textColor);
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildLineChart(List<FlSpot> flChartData, Color textColor) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: flChartData,
            isCurved: true,
            barWidth: widget.lineThickness,
            gradient: LinearGradient(
              colors: [
                generateColorVariant(widget.scheme, 0, flChartData.length),
                generateColorVariant(widget.scheme, 0, flChartData.length)
                    .withOpacity(0.6),
              ],
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  generateColorVariant(widget.scheme, 0, flChartData.length)
                      .withOpacity(0.4),
                  generateColorVariant(widget.scheme, 0, flChartData.length)
                      .withOpacity(0.1),
                ],
              ),
            ),
            dotData: FlDotData(
              show: widget.showDataPoints,
            ),
          ),
        ],
        gridData: FlGridData(
          show: widget.showGridLines,
        ),
        titlesData: _buildTitlesData(textColor),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  'X: ${spot.x}, Y: ${spot.y}',
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
      ),
      duration: const Duration(milliseconds: 600),
    );
  }

  Widget _buildBarChart(List<FlSpot> flChartData, Color textColor) {
    return BarChart(
      BarChartData(
        barGroups: flChartData.asMap().entries.map((entry) {
          final index = entry.key;
          final spot = entry.value;
          return BarChartGroupData(
            x: spot.x.toInt(),
            barRods: [
              BarChartRodData(
                toY: spot.y,
                gradient: LinearGradient(
                  colors: [
                    generateColorVariant(
                        widget.scheme, index, flChartData.length),
                    generateColorVariant(
                            widget.scheme, index, flChartData.length)
                        .withOpacity(0.5),
                  ],
                ),
                width: widget.lineThickness * 5,
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          );
        }).toList(),
        titlesData: _buildTitlesData(textColor),
        gridData: FlGridData(
          show: widget.showGridLines,
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                'Value: ${rod.toY}',
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart(List<FlSpot> flChartData, Color textColor) {
    final xValues =
        (widget.xInput ?? '').split(',').map((e) => e.trim()).toList();

    return Column(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              sections: flChartData.asMap().entries.map((entry) {
                final index = entry.key;
                final spot = entry.value;

                final title = index < xValues.length ? xValues[index] : '';
                final radius = widget.explodeSlices && index == touchedIndex
                    ? 120.0
                    : 100.0;

                return PieChartSectionData(
                  value: spot.y.toDouble(),
                  title: title,
                  gradient: LinearGradient(
                    colors: [
                      generateColorVariant(
                          widget.scheme, index, flChartData.length),
                      generateColorVariant(
                              widget.scheme, index, flChartData.length)
                          .withOpacity(0.5),
                    ],
                  ),
                  radius: radius,
                  titleStyle: TextStyle(
                    fontSize: widget.axisLabelFontSize,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                );
              }).toList(),
              centerSpaceRadius: 40,
              sectionsSpace: 4,
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    touchedIndex =
                        pieTouchResponse?.touchedSection?.touchedSectionIndex ??
                            -1;
                  });
                },
              ),
            ),
          ),
        ),
        if (widget.showLegend) _buildLegend(flChartData, textColor),
      ],
    );
  }

  Widget _buildScatterChart(List<FlSpot> flChartData, Color textColor) {
    return ScatterChart(
      ScatterChartData(
        scatterSpots: flChartData.map((spot) {
          final index = flChartData.indexOf(spot);
          return ScatterSpot(
            spot.x,
            spot.y,
            dotPainter: widget.showDataPoints
                ? FlDotCirclePainter(
                    radius: widget.dataPointSize,
                    color: generateColorVariant(
                        widget.scheme, index, flChartData.length),
                  )
                : FlDotCirclePainter(
                    radius: 0,
                    color: Colors.transparent,
                  ),
          );
        }).toList(),
        titlesData: _buildTitlesData(textColor),
        gridData: FlGridData(
          show: widget.showGridLines,
          horizontalInterval: 10,
          verticalInterval: 1,
        ),
        scatterTouchData: ScatterTouchData(
          touchTooltipData: ScatterTouchTooltipData(
            getTooltipItems: (touchedSpot) {
              return ScatterTooltipItem(
                'X: ${touchedSpot.x}, Y: ${touchedSpot.y}',
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  FlTitlesData _buildTitlesData(Color textColor) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: widget.showAxisLabels,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toInt().toString(),
              style: TextStyle(
                fontSize: widget.axisLabelFontSize,
                color: textColor,
              ),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: widget.showAxisLabels,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toInt().toString(),
              style: TextStyle(
                fontSize: widget.axisLabelFontSize,
                color: textColor,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLegend(List<FlSpot> flChartData, Color textColor) {
    final xValues =
        (widget.xInput ?? '').split(',').map((e) => e.trim()).toList();
    if (xValues.isEmpty || flChartData.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: flChartData.asMap().entries.map((entry) {
          final index = entry.key;
          final label = index < xValues.length ? xValues[index] : 'N/A';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: generateColorVariant(
                        widget.scheme, index, flChartData.length),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: widget.legendFontSize,
                    color: textColor,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
