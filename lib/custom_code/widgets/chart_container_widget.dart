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

class ChartContainerWidget extends StatefulWidget {
  const ChartContainerWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ChartContainerWidget> createState() => _ChartContainerWidgetState();
}

class _ChartContainerWidgetState extends State<ChartContainerWidget> {
  // Listener method that triggers a rebuild on App State change
  void _onAppStateChange() {
    print("App State changed, rebuilding ChartContainerWidget...");
    setState(() {}); // Force rebuild on App State change
  }

  @override
  void initState() {
    super.initState();
    // Listen to App State changes
    FFAppState().addListener(_onAppStateChange);
  }

  @override
  void dispose() {
    // Remove the App State listener when the widget is disposed to avoid memory leaks
    FFAppState().removeListener(_onAppStateChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 400.0,
      child: ChartDisplayWidget(
        key: ValueKey(FFAppState().chartTitle +
            FFAppState().chartType +
            FFAppState().scheme),
        title: FFAppState().chartTitle,
        scheme: FFAppState().scheme,
        lineThickness: FFAppState().lineThickness,
        dataPointSize: FFAppState().dataPointSize,
        chartType: FFAppState().chartType,
        showDataPoints: FFAppState().showDataPoints,
        showGridLines: FFAppState().showGridLines,
        showAxisLabels: FFAppState().showAxisLabels,
        showLegend: FFAppState().showLegend,
        explodeSlices: FFAppState().explodeSlices,
        titleFontSize: FFAppState().titleFontSize,
        axisLabelFontSize: FFAppState().axisLabelFontSize,
        legendFontSize: FFAppState().legendFontSize,
        xInput: FFAppState().xInput,
        yInput: FFAppState().yInput,
        mode: FFAppState().mode,
      ),
    );
  }
}
