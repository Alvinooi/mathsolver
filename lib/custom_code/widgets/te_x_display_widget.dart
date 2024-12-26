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

import 'package:flutter_math_fork/flutter_math.dart';

class TeXDisplayWidget extends StatefulWidget {
  const TeXDisplayWidget({
    super.key,
    this.width,
    this.height,
    required this.mathExpression,
  });

  final double? width;
  final double? height;
  final String mathExpression;

  @override
  State<TeXDisplayWidget> createState() => _TeXDisplayWidgetState();
}

class _TeXDisplayWidgetState extends State<TeXDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    // Use the theme to determine the text color
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      color: Colors.transparent, // Transparent background
      child: Align(
        alignment: Alignment.centerLeft, // Align the Math.tex to the left
        child: Math.tex(
          widget.mathExpression, // Use the widget's mathExpression
          textStyle: TextStyle(
            fontSize: 18, // Adjust font size as needed
            color: textColor, // Dynamically set the text color
          ),
        ),
      ),
    );
  }
}
