import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String convertMessagesToSingleString(List<MessageRecord> messagesList) {
  // Map each MessageRecord to a formatted string with role and content
  String formattedString = messagesList.map((message) {
    // Identify the role as "User" or "Model" and format the message
    String role = message.type == 'user' ? "User" : "Model";
    return "$role: ${message.content ?? ""}";
  }).join("\n"); // Join each message with a newline for readability

  // Return the single formatted string in a list (for FlutterFlow compatibility)
  return formattedString;
}

String convertTimestampToReadableDateTime(String? datetime) {
  // convert date time string to human readable format
  if (datetime == null) {
    return '';
  }

  DateTime parsedDateTime = DateTime.parse(datetime);
  String formattedDateTime =
      DateFormat('MMM dd, yyyy hh:mm a').format(parsedDateTime);
  return formattedDateTime;
}

Color getColor(
  String scheme,
  String? color,
) {
  final schemes = {
    'cb': {
      // Classic Blue
      'p': Color(0xFF1976D2), // Primary
      's': Color(0xFF1E88E5), // Secondary
      't': Color(0xFF42A5F5), // Tertiary
      'q': Color(0xFF90CAF9), // Quaternary
      'a': Color(0xFF0D47A1), // Additional
    },
    'ng': {
      // Nature Green
      'p': Color(0xFF388E3C),
      's': Color(0xFF43A047),
      't': Color(0xFF66BB6A),
      'q': Color(0xFFA5D6A7),
      'a': Color(0xFF1B5E20),
    },
    'cg': {
      // Cool Gray
      'p': Color(0xFF616161),
      's': Color(0xFF757575),
      't': Color(0xFF9E9E9E),
      'q': Color(0xFFBDBDBD),
      'a': Color(0xFF424242),
    },
    'ob': {
      // Ocean Breeze
      'p': Color(0xFF00838F),
      's': Color(0xFF00ACC1),
      't': Color(0xFF4DD0E1),
      'q': Color(0xFF80DEEA),
      'a': Color(0xFF004D40),
    },
    'dn': {
      // Dark Neon
      'p': Color(0xFFFF4081),
      's': Color(0xFF40C4FF),
      't': Color(0xFF69F0AE),
      'q': Color(0xFFFFD740),
      'a': Color(0xFFFFAB40),
    },
    'pr': {
      // Pastel Rainbow
      'p': Color(0xFFF48FB1),
      's': Color(0xFFCE93D8),
      't': Color(0xFF90CAF9),
      'q': Color(0xFFA5D6A7),
      'a': Color(0xFFFFCC80),
    },
  };

  // Return the color based on scheme and color type
  return schemes[scheme]?[color] ?? Colors.grey; // Default to grey if not found
}

String? validateInput(
  String? graphType,
  String? fieldName,
  String? fieldValue,
) {
  // Handle null graphType or fieldName cases
  if (graphType == null || fieldName == null) {
    return 'Invalid: Graph type or field name is null.';
  }

  // Define regex patterns for validation
  final Map<String, String> regexPatterns = {
    'X-Axis Labels': r'^[A-Za-z0-9 ,.-]+$',
    'Y-Axis Data': r'^(-?\d+(\.\d+)?)(, *-?\d+(\.\d+)?)*$',
    'Equation Input': r'^[yY]=[ A-Za-z0-9^+\-*/().]+$',
    'Coefficient Inputs': r'^(-?\d+(\.\d+)?)(, *-?\d+(\.\d+)?)*$',
  };

  // Define error messages for validation
  final Map<String, String> errorMessages = {
    'X-Axis Labels': 'X-Axis Labels must be alphanumeric and comma-separated.',
    'Y-Axis Data':
        'Y-Axis Data must be numeric (integers or decimals) and comma-separated.',
    'Equation Input':
        'Equation Input must start with "y =" or "Y =" and include a valid mathematical expression.',
    'Coefficient Inputs':
        'Coefficient Inputs must be numeric (integers or decimals) and comma-separated.',
  };

  // Define required fields based on graph type
  final Map<String, List<String>> requiredFieldsByGraphType = {
    'Bar': ['X-Axis Labels', 'Y-Axis Data'],
    'Pie': ['X-Axis Labels', 'Y-Axis Data'],
    'Line': ['X-Axis Labels', 'Y-Axis Data'],
    'Scatter': ['X-Axis Labels', 'Y-Axis Data'],
    'Mathematical': ['Equation Input', 'Coefficient Inputs'],
  };

  // Check which fields are required for the given graph type
  List<String>? requiredFields = requiredFieldsByGraphType[graphType];
  if (requiredFields == null) {
    return 'Invalid graph type provided.';
  }

  // Validate the specific field
  if (requiredFields.contains(fieldName)) {
    if (fieldValue == null || fieldValue.isEmpty) {
      return 'Invalid: $fieldName is required for $graphType but not provided.';
    }
  } else {
    return "Invalid field.";
  }

  return 'Validation Passed';
}

String? compareInputConsistency(
  String? xAxisLabels,
  String? yAxisData,
  String? equationInput,
  String? coefficientInputs,
) {
  // Validate that X-Axis Labels and Y-Axis Data have the same number of entries
  if (xAxisLabels != null && yAxisData != null) {
    if (xAxisLabels.isNotEmpty && yAxisData.isNotEmpty) {
      List<String> xLabels =
          xAxisLabels.split(',').map((e) => e.trim()).toList();
      List<String> yData = yAxisData.split(',').map((e) => e.trim()).toList();

      if (xLabels.length >= 1 &&
          yData.length >= 1 &&
          xLabels.length != yData.length) {
        return 'Invalid: The number of X-Axis labels (${xLabels.length}) does not match the number of Y-Axis data points (${yData.length}).';
      }
    }
  }

  // Validate that Equation Input and Coefficient Inputs are consistent
  if (equationInput != null && coefficientInputs != null) {
    if (equationInput.isNotEmpty && coefficientInputs.isNotEmpty) {
      RegExp coefficientPattern = RegExp(r'-?\d+(\.\d+)?');
      Iterable<Match> matches =
          coefficientPattern.allMatches(coefficientInputs);

      int coefficientCount = matches.length;
      int expectedCount = equationInput.split(RegExp(r'[a-zA-Z]')).length - 1;

      if (coefficientCount >= 1 &&
          expectedCount >= 1 &&
          coefficientCount != expectedCount) {
        return 'Invalid: The number of coefficients provided ($coefficientCount) does not match the number of variables in the equation ($expectedCount).';
      }
    }
  }

  return 'Validation Passed';
}

bool validateFileForGraphVisualization(FFUploadedFile file) {
  // Check if the file is not null and has content
  if (file == null || file.bytes == null || file.bytes!.isEmpty) {
    return false;
  }

  // Convert the file content to a string
  String content = utf8.decode(file.bytes!);

  // Attempt to parse the content based on common data formats (CSV, space/tab-separated, JSON)
  List<String> lines =
      content.split('\n').where((line) => line.trim().isNotEmpty).toList();

  // Check if it is a CSV or space/tab-separated format
  if (lines.isNotEmpty) {
    for (int i = 1; i < lines.length; i++) {
      List<String> columns = lines[i].split(RegExp(r'[,\t ]+'));

      // Ensure there are at least two numerical columns
      if (columns.length >= 2) {
        if (double.tryParse(columns[0]) == null ||
            double.tryParse(columns[1]) == null) {
          return false; // Invalid x or y value
        }
      } else {
        return false; // Not enough columns
      }
    }

    // If all rows are valid, return true
    return true;
  }

  // Attempt to parse JSON format
  try {
    final jsonData = jsonDecode(content);

    // Check if JSON is a list of objects or arrays with x and y values
    if (jsonData is List) {
      for (var item in jsonData) {
        if (item is Map && item.containsKey('x') && item.containsKey('y')) {
          if (double.tryParse(item['x'].toString()) == null ||
              double.tryParse(item['y'].toString()) == null) {
            return false; // Invalid numerical value in JSON
          }
        } else if (item is List && item.length >= 2) {
          if (double.tryParse(item[0].toString()) == null ||
              double.tryParse(item[1].toString()) == null) {
            return false; // Invalid numerical value in JSON array
          }
        } else {
          return false; // Invalid structure in JSON
        }
      }

      // JSON format is valid if all checks pass
      return true;
    }
  } catch (e) {
    // JSON parsing failed, return false
    return false;
  }

  // If no valid format matched, return false
  return false;
}

String getFileName(FFUploadedFile file) {
  String fileName = '';
  // Check if the file is valid
  if (file == null || file.name == null || file.name!.isEmpty) {
    fileName = 'Invalid file or file name is empty';
  } else {
    fileName = file.name!;
  }

  // Return the file name
  return fileName;
}

String checkFileForGraphErrors(FFUploadedFile file) {
  // Check if the file is not null and has content
  if (file == null) {
    return 'File is not provided.';
  }
  if (file.bytes == null || file.bytes!.isEmpty) {
    return 'File content is empty or corrupted.';
  }

  // Convert the file content to a string
  String content = utf8.decode(file.bytes!);

  // Attempt to parse the content based on common data formats (CSV, space/tab-separated, JSON)
  List<String> lines =
      content.split('\n').where((line) => line.trim().isNotEmpty).toList();

  // Check if it is a CSV or space/tab-separated format
  if (lines.isNotEmpty) {
    for (int i = 1; i < lines.length; i++) {
      List<String> columns = lines[i].split(RegExp(r'[,\t ]+'));

      // Ensure there are at least two numerical columns
      if (columns.length < 2) {
        return 'Line ${i + 1} does not have enough columns for x and y values.';
      }
      if (double.tryParse(columns[0]) == null ||
          double.tryParse(columns[1]) == null) {
        return 'Line ${i + 1} contains invalid numerical values for x or y.';
      }
    }
  } else {
    // No valid CSV or table-like data found
    return 'File does not contain valid CSV or table-like data.';
  }

  // Attempt to parse JSON format
  try {
    final jsonData = jsonDecode(content);

    // Check if JSON is a list of objects or arrays with x and y values
    if (jsonData is List) {
      for (int i = 0; i < jsonData.length; i++) {
        var item = jsonData[i];
        if (item is Map && item.containsKey('x') && item.containsKey('y')) {
          if (double.tryParse(item['x'].toString()) == null ||
              double.tryParse(item['y'].toString()) == null) {
            return 'Item at index ${i} in JSON contains invalid numerical values for x or y.';
          }
        } else if (item is List && item.length >= 2) {
          if (double.tryParse(item[0].toString()) == null ||
              double.tryParse(item[1].toString()) == null) {
            return 'Array at index ${i} in JSON contains invalid numerical values for x or y.';
          }
        } else {
          return 'Item at index ${i} in JSON does not have a valid structure with x and y.';
        }
      }
    } else {
      return 'JSON structure is invalid. It must be a list of objects or arrays.';
    }
  } catch (e) {
    // JSON parsing failed, return an error message
    return 'Failed to parse JSON content: ${e.toString()}';
  }

  // If all checks pass, return a success message
  return 'File is valid for graph visualization.';
}

List<String> convertList(String expression) {
  final regex = RegExp(r'(\d+|[a-zA-Z]+|[+\-*/^()=<>!]|\\[a-zA-Z]+|∞|,|\.)');

  // Use regex to find and extract all matches in the string
  return regex.allMatches(expression).map((match) => match.group(0)!).toList();
}

String formatPrompt(String prompt) {
  // Step 1: Sanitize input (removes control characters and trims whitespace)
  prompt = prompt.replaceAll(RegExp(r"[\u0000-\u001F]"), "").trim();

  // Step 2: Define enhanced hardcoded examples with detailed explanations
  // Hardcoded examples
  List<Map<String, String>> examples = [
    {
      "problem": "Solve for x: 5x + 10 = 35.",
      "steps":
          "Step 1: Subtract 10 from both sides: 5x = 25. Step 2: Divide by 5: x = 5.",
      "answer": "5"
    }
  ];

  // Step 3: Build the formatted prompt with clear structure and examples
  String formattedPrompt = "";
  for (var example in examples) {
    formattedPrompt += "Problem: ${example['problem']} ";
    formattedPrompt += "${example['steps']} ";
    formattedPrompt += "Final answer: ${example['answer']} ";
  }

  // Step 4: Add the sanitized user-provided prompt as a new problem

  formattedPrompt +=
      "Now that you've reviewed the format, try solving the following problem using a similar format with step-by-step approach. Make sure the output is formatted and structured well in three sections, e.g. problems, solutions and final answer.";
  formattedPrompt += "Problem:$prompt";
  formattedPrompt += "Solution Steps:Step 1: ";

  return formattedPrompt;
}

String postProcessOutput(
  String output,
  String problem,
) {
  // Define the target phrase
  String targetPhrase =
      "Now that you've reviewed the examples, try solving the following problem using a similar step-by-step approach.";

  // Find the start index of the target phrase
  int startIndex = output.indexOf(targetPhrase);

  if (startIndex != -1) {
    // Extract content after the target phrase
    String relevantOutput =
        output.substring(startIndex + targetPhrase.length).trim();
    return relevantOutput;
  }

  // If the target phrase is not found, return an error message
  return "Target phrase not found.";
}

List<ChatRecord>? getCommonChat(
  List<ChatRecord> list1,
  List<ChatRecord> list2,
) {
  // Convert the first list to a set for efficient lookup
  final set1 = list1.toSet();

  // Find the intersection between the two sets
  final commonChats = set1.intersection(list2.toSet()).toList();

  // Return the list of common ChatRecord objects
  return commonChats;
}

String convertListToString(List<String> list) {
  return list.join(' ');
}

List<DocumentReference> combineList(
  List<DocumentReference> set1,
  List<DocumentReference> set2,
) {
  // combine two list of user document reference, make sure no duplicated
  Set<DocumentReference> combinedSet = {...set1, ...set2};
  return combinedSet.toList();
}
