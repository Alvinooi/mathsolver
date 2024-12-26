// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:typed_data';

Future<FFUploadedFile?> retrieveImageFromFirebase(String imageUrl) async {
  try {
    // Fetch the image data from the provided URL
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // If the request is successful, create an FFUploadedFile object
      Uint8List imageData = response.bodyBytes;

      // Create an FFUploadedFile to store the data
      FFUploadedFile uploadedFile = FFUploadedFile(
        bytes: imageData,
        name: imageUrl.split('/').last, // Extract the file name from the URL
      );

      return uploadedFile;
    } else {
      // Handle the case when the request fails
      return null;
    }
  } catch (e) {
    return null;
  }
}
