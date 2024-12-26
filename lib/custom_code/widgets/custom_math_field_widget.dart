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

import 'package:math_keyboard/math_keyboard.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:fraction/fraction.dart'; // Ensure this import is present

// Add these imports if you need to access app state management functions

class CustomMathFieldWidget extends StatefulWidget {
  const CustomMathFieldWidget({
    Key? key,
    this.width,
    this.height,
    this.expression,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? expression;

  @override
  State<CustomMathFieldWidget> createState() => _CustomMathFieldWidgetState();
}

class _CustomMathFieldWidgetState extends State<CustomMathFieldWidget> {
  late Expression _expression;
  late final _controller = MathFieldEditingController();
  final FocusNode _focusNode = FocusNode(); // FocusNode to control the field
  String _result = '';
  String _alternativeResult = '';
  String _currentExpression =
      ''; // Add a variable to store the current expression

  @override
  void initState() {
    super.initState();

    _clearInput();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.expression != null && widget.expression!.isNotEmpty) {
        _currentExpression = widget.expression!;
        _populateAndCalculate(widget.expression!);
      }
    });
  }

  @override
  void didUpdateWidget(covariant CustomMathFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.expression != widget.expression &&
        widget.expression != null &&
        widget.expression!.isNotEmpty) {
      _currentExpression = widget.expression!;
      _populateAndCalculate(widget.expression!);
    }
  }

  @override
  void dispose() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
    _controller.clear();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _populateAndCalculate(String texExpression) {
    try {
      print("Received Expression: $texExpression"); // Debug log

      // Parse the LaTeX-like string into an Expression using TeXParser
      final parsedExpression = TeXParser(texExpression).parse();

      // Update the MathField controller with the parsed Expression
      setState(() {
        _expression = parsedExpression;
        _controller.updateValue(parsedExpression); // Update the MathField
      });

      // Compute the result
      _computeResult();
    } catch (e) {
      print("Error parsing expression: $e"); // Debug log
      setState(() {
        _result = 'Error';
        _alternativeResult = '';
      });
    }
  }

  void _computeResult() {
    try {
      final evaluatedResult =
          _expression.evaluate(EvaluationType.REAL, ContextModel()) as double;

      print("Evaluated Result: $evaluatedResult"); // Debug log

      setState(() {
        _result = _formatResult(evaluatedResult);

        _alternativeResult = _getAlternativeForms(evaluatedResult);

        // Save input and results to app state
        FFAppState().currentInput = _controller.currentEditingValue();
        FFAppState().currentResult = _result;
        FFAppState().alternativeResult = _alternativeResult;
      });
    } catch (e) {
      print("Error in _computeResult: $e"); // Debug log
      setState(() {
        _result = 'Error';
        _alternativeResult = '';
      });
    }
  }

  String _formatResult(double value) {
    if (value % 1 == 0) {
      // Check if the value is a whole number
      return value
          .toInt()
          .toString(); // Convert to an integer and return as string
    } else if (value.abs() >= 1e6 || value.abs() < 1e-3) {
      // Use scientific notation for very large or small numbers
      return value.toStringAsExponential(5);
    }
    // Use fixed-point notation for other cases
    return value.toStringAsFixed(5);
  }

  String _getAlternativeForms(double value) {
    List<String> alternatives = [];

    final fraction = Fraction.fromDouble(value);
    if (fraction.denominator != 1) {
      alternatives.add(fraction.toString());
    }

    final scientificNotation = value.toStringAsExponential(5);
    if (scientificNotation != _result) {
      alternatives.add(scientificNotation);
    }

    return alternatives.join(', ');
  }

  void _clearInput() {
    setState(() {
      _controller.clear();
      _result = '';
      _alternativeResult = '';
      _currentExpression = ''; // Clear the displayed expression

      FFAppState().currentInput = '';
      FFAppState().currentResult = '';
      FFAppState().alternativeResult = '';
    });

    _unfocusField(); // Unfocus after clearing
  }

  void _unfocusField() {
    _focusNode.unfocus(); // Close the keyboard
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocusField, // Close the keyboard when tapping outside
      child: Container(
        width: widget.width ?? double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: MathField(
                    controller: _controller,
                    focusNode: _focusNode, // Attach FocusNode
                    autofocus: true,
                    variables: [],
                    decoration: const InputDecoration(
                        hintText: 'Enter expression...',
                        border: InputBorder.none),
                    onChanged: (tex) {
                      if (tex.isEmpty) {
                        _clearInput();
                      } else {
                        _expression = TeXParser(tex).parse();
                        _computeResult();
                      }
                    },
                  ),
                ),
                TextButton(
                  onPressed: _clearInput,
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            if (_result.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '= ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _result,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (_alternativeResult.isNotEmpty &&
                      _alternativeResult != _result)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Alternative Form',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '$_alternativeResult',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
