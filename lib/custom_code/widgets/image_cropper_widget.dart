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

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:crop_image/crop_image.dart';

class ImageCropperWidget extends StatefulWidget {
  const ImageCropperWidget({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    required this.onCropCompleted,
    required this.userId,
  });

  final double? width;
  final double? height;
  final String imageUrl;
  final Future Function(String uploadedImagePath) onCropCompleted;
  final String userId;

  @override
  State<ImageCropperWidget> createState() => _ImageCropperWidgetState();
}

class _ImageCropperWidgetState extends State<ImageCropperWidget> {
  late CropController _controller;
  Image? _loadedImage;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _controller = CropController();
    _loadImageFromUrl();
  }

  Future<void> _loadImageFromUrl() async {
    try {
      final response = await http.get(Uri.parse(widget.imageUrl));
      if (response.statusCode == 200) {
        _imageBytes = response.bodyBytes;
        setState(() {
          _loadedImage = Image.memory(_imageBytes!);
        });
      } else {
        throw Exception("Failed to load image from URL");
      }
    } catch (e) {
      debugPrint("Error loading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loadedImage == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Expanded(
            child: CropImage(
              controller: _controller,
              image: _loadedImage!,
              paddingSize: 25.0,
              alwaysMove: true,
            ),
          ),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.refresh, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            _controller.rotation = CropRotation.up;
            _controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
            _controller.aspectRatio = 1.0;
          },
        ),
        IconButton(
          icon: Icon(Icons.aspect_ratio,
              color: Theme.of(context).iconTheme.color),
          onPressed: _aspectRatios,
        ),
        IconButton(
          icon: Icon(Icons.rotate_90_degrees_ccw_outlined,
              color: Theme.of(context).iconTheme.color),
          onPressed: _rotateLeft,
        ),
        IconButton(
          icon: Icon(Icons.rotate_90_degrees_cw_outlined,
              color: Theme.of(context).iconTheme.color),
          onPressed: _rotateRight,
        ),
        TextButton(
          onPressed: () {
            _finished();
          },
          child: Text(
            'Done',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }

  Future<void> _aspectRatios() async {
    final value = await showDialog<double>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: Text(
            'Select aspect ratio',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, -1.0),
              child: Text(
                'free',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 1.0),
              child: Text(
                'square',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 2.0),
              child: Text(
                '2:1',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 1 / 2),
              child: Text(
                '1:2',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 4.0 / 3.0),
              child: Text(
                '4:3',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 16.0 / 9.0),
              child: Text(
                '16:9',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        );
      },
    );
    if (value != null) {
      _controller.aspectRatio = value == -1 ? null : value;
      _controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
    }
  }

  Future<void> _rotateLeft() async => _controller.rotateLeft();

  Future<void> _rotateRight() async => _controller.rotateRight();

  Future<void> _finished() async {
    try {
      final ui.Image croppedBitmap = await _controller.croppedBitmap();

      final ByteData? byteData =
          await croppedBitmap.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        throw Exception("Failed to convert cropped image to bytes.");
      }
      final Uint8List croppedBytes = byteData.buffer.asUint8List();

      // Upload the cropped image and get the download URL
      final String downloadUrl = await _uploadCroppedImage(croppedBytes);

      // Pass the download URL to the callback
      await widget.onCropCompleted(downloadUrl);
    } catch (e) {
      debugPrint("Error during cropping or upload: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: $e",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onError),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<String> _uploadCroppedImage(Uint8List croppedBytes) async {
    try {
      final String filePath =
          'users/${widget.userId}/cropped_image_${DateTime.now().millisecondsSinceEpoch}.png';
      final ref = FirebaseStorage.instance.ref().child(filePath);

      // Upload the cropped image
      final uploadTask = ref.putData(croppedBytes);
      await uploadTask.whenComplete(() => null);

      // Retrieve the download URL
      final String downloadUrl = await ref.getDownloadURL();

      return downloadUrl; // Return the URL for accessing the uploaded image
    } catch (e) {
      debugPrint("Upload error: $e");
      throw Exception("Failed to upload image. Error: $e");
    }
  }
}
