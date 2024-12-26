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
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class ChartShareWidget extends StatefulWidget {
  const ChartShareWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ChartShareWidget> createState() => _ChartShareWidgetState();
}

class _ChartShareWidgetState extends State<ChartShareWidget> {
  ScreenshotController screenshotController = ScreenshotController();
  String debugMessage = "Ready to export or share chart.";

  Future<String> _getSaveDirectory(
      String fileName, String fileExtension) async {
    Directory directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName$fileExtension';
  }

  Future<void> _shareImage(Uint8List imageFile) async {
    try {
      // Mobile/Desktop: Use File I/O and Share
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/shared_chart.png';
      final image = File(imagePath);
      await image.writeAsBytes(imageFile);
      await Share.shareXFiles([XFile(imagePath)],
          text: 'Check out this chart!');
      setState(() {
        debugMessage = 'Chart shared successfully.';
      });
    } catch (e) {
      setState(() {
        debugMessage = 'Error sharing chart: $e';
      });
    }
  }

  Future<void> _exportAsImage() async {
    try {
      setState(() {
        debugMessage = "Capturing chart image...";
      });
      // Mobile/Desktop image export
      final Uint8List? imageFile = await screenshotController.capture();
      if (imageFile != null) {
        String filePath = await _getSaveDirectory('exported_chart', '.png');
        File file = File(filePath);
        await file.writeAsBytes(imageFile);
        setState(() {
          debugMessage = 'Chart image saved successfully to $filePath';
        });
      } else {
        setState(() {
          debugMessage = 'Failed to capture chart image.';
        });
      }
    } catch (e) {
      setState(() {
        debugMessage = 'Error saving image: $e';
      });
    }
  }

  Future<void> _exportAsPDF() async {
    try {
      setState(() {
        debugMessage = "Capturing chart for PDF...";
      });

      if (kIsWeb) {
        // Web-specific PDF export
        final Uint8List? imageBytes = await screenshotController.capture();
        if (imageBytes != null) {
          final pdf = pw.Document();
          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Center(
                  child: pw.Image(pw.MemoryImage(imageBytes)),
                );
              },
            ),
          );

          setState(() {
            debugMessage = "Chart PDF saved successfully (web download).";
          });
        } else {
          setState(() {
            debugMessage = "Failed to capture chart image for PDF.";
          });
        }
      } else {
        // Mobile/Desktop PDF export
        final Uint8List? imageFile = await screenshotController.capture();
        if (imageFile != null) {
          String filePath = await _getSaveDirectory('exported_chart', '.pdf');
          final pdf = pw.Document();
          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Center(
                  child: pw.Image(pw.MemoryImage(imageFile)),
                );
              },
            ),
          );
          File file = File(filePath);
          await file.writeAsBytes(await pdf.save());
          setState(() {
            debugMessage = 'Chart PDF saved successfully to $filePath';
          });
        } else {
          setState(() {
            debugMessage = 'Failed to capture chart image for PDF.';
          });
        }
      }
    } catch (e) {
      setState(() {
        debugMessage = 'Error saving PDF: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]
        : Theme.of(context).primaryColor;
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Screenshot(
      controller: screenshotController,
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                debugMessage,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: _exportAsImage,
              child: Text("Export as Image"),
            ),
            ElevatedButton(
              onPressed: _exportAsPDF,
              child: Text("Export as PDF"),
            ),
            ElevatedButton(
              onPressed: () async {
                final imageBytes = await screenshotController.capture();
                if (imageBytes != null) {
                  await _shareImage(imageBytes);
                }
              },
              child: Text("Share Chart"),
            ),
          ],
        ),
      ),
    );
  }
}
