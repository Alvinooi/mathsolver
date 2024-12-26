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

class MathStepSolutionDisplay extends StatefulWidget {
  const MathStepSolutionDisplay({
    super.key,
    this.width,
    this.height,
    required this.modelOutput,
    required this.type,
  });

  final double? width;
  final double? height;
  final String modelOutput;
  final String type;

  @override
  State<MathStepSolutionDisplay> createState() =>
      _MathStepSolutionDisplayState();
}

class _MathStepSolutionDisplayState extends State<MathStepSolutionDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.transparent, // Fully transparent background
        borderRadius: BorderRadius.circular(8), // Keep corner radius if needed
        boxShadow: [
          BoxShadow(
            color: Colors.transparent, // No shadow (optional)
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: widget.type == 'user'
            ? _buildPlainText(widget.modelOutput)
            : _buildMathSolution(widget.modelOutput),
      ),
    );
  }

  Widget _buildPlainText(String content) {
    final textColor = widget.type == 'system'
        ? Colors.white
        : Theme.of(context).colorScheme.onSurface; // Adapts to dark/light mode

    return Text(
      content,
      style: TextStyle(
        fontSize: 16,
        color: textColor,
        height: 1.5, // Line height for better readability
      ),
    );
  }

  Widget _buildMathSolution(String content) {
    final sectionHeaders = [
      r'Problem:',
      r'Solutions?:',
      r'Solution:',
      r'Step \d+:', // Matches Step 1:, Step 2:, etc.
      r'(Final )?Answers?:' // Matches Answer, Answers, Final Answer
    ];

    final sections = _splitByHeaders(content, sectionHeaders);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) {
        if (section.isEmpty) {
          return const SizedBox(height: 16); // Add spacing for empty lines
        }

        final isProblem =
            RegExp(r'^Problem:', caseSensitive: false).hasMatch(section);
        final isSolution =
            RegExp(r'^Solutions?:', caseSensitive: false).hasMatch(section);
        final isStep =
            RegExp(r'^Step \d+:', caseSensitive: false).hasMatch(section);
        final isFinalAnswer =
            RegExp(r'^(Final )?Answers?:', caseSensitive: false)
                .hasMatch(section);

        final textColor = widget.type == 'system'
            ? Colors.white
            : (isFinalAnswer
                ? Colors.green
                : Theme.of(context)
                    .colorScheme
                    .onSurface); // Adapts dynamically

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            section.trim(),
            style: TextStyle(
              fontSize:
                  isProblem || isSolution ? 18 : (isFinalAnswer ? 16 : 14),
              fontWeight: isProblem || isSolution || isFinalAnswer
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: textColor,
              height: 1.5, // Line height for readability
            ),
          ),
        );
      }).toList(),
    );
  }

  List<String> _splitByHeaders(String content, List<String> headers) {
    final regex = RegExp('(${headers.join('|')})', caseSensitive: false);

    final matches = regex.allMatches(content);
    if (matches.isEmpty) {
      return [content]; // No headers detected, return full content
    }

    final sections = <String>[];
    int start = 0;

    for (final match in matches) {
      if (start != match.start) {
        sections.add(content.substring(start, match.start).trim());
      }
      start = match.start;
    }

    if (start < content.length) {
      sections.add(content.substring(start).trim());
    }

    return sections;
  }
}
