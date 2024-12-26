import '/flutter_flow/flutter_flow_util.dart';
import 'graph3c_widget.dart' show Graph3cWidget;
import 'package:flutter/material.dart';

class Graph3cModel extends FlutterFlowModel<Graph3cWidget> {
  ///  Local state fields for this page.

  bool? validationField1;

  bool? validationField2;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - getXYStringFromFile] action in Button widget.
  String? xreturn;
  // Stores action output result for [Custom Action - getXYStringFromFile] action in Button widget.
  String? yreturn;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
