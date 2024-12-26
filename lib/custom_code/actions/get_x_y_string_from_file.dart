// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import '/flutter_flow/uploaded_file.dart';

String getXYStringFromFile(
  FFUploadedFile file,
  bool returnX,
) {
  // Check if the file is not null and has content
  if (file == null || file.bytes == null || file.bytes!.isEmpty) {
    throw Exception('Invalid file or empty content');
  }

  // Convert the file content to a string
  String content = utf8.decode(file.bytes!);

  List<String> xValues = [];
  List<String> yValues = [];

  // Attempt to parse the content based on common data formats (CSV, space/tab-separated, JSON)
  List<String> lines =
      content.split('\n').where((line) => line.trim().isNotEmpty).toList();

  // Parse CSV or space/tab-separated format
  if (lines.isNotEmpty) {
    for (int i = 1; i < lines.length; i++) {
      List<String> columns = lines[i].split(RegExp(r'[,\t ]+'));
      if (columns.length >= 2) {
        xValues.add(columns[0]);
        yValues.add(columns[1]);
      }
    }
  } else {
    // Attempt to parse JSON format
    try {
      final jsonData = jsonDecode(content);
      if (jsonData is List) {
        for (var item in jsonData) {
          if (item is Map && item.containsKey('x') && item.containsKey('y')) {
            xValues.add(item['x'].toString());
            yValues.add(item['y'].toString());
          } else if (item is List && item.length >= 2) {
            xValues.add(item[0].toString());
            yValues.add(item[1].toString());
          }
        }
      }
    } catch (e) {
      throw Exception('Error parsing JSON format');
    }
  }

  // Return the requested string
  return returnX ? xValues.join(', ') : yValues.join(', ');
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
