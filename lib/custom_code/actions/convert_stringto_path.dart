// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_storage/firebase_storage.dart';

Future<String> convertStringtoPath(String imageUrl) async {
  // Check if the string is already a URL
  if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
    // Return the URL directly if it is a valid network URL
    return imageUrl;
  } else {
    // Assume it's a Firebase Storage path
    try {
      final ref = FirebaseStorage.instance.ref(imageUrl);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl; // Return the generated download URL
    } catch (e) {
      // Handle errors, e.g., invalid path or no access
      throw Exception("Failed to convert path to URL: $e");
    }
  }
}
