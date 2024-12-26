import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'scan_solve_widget.dart' show ScanSolveWidget;
import 'package:flutter/material.dart';

class ScanSolveModel extends FlutterFlowModel<ScanSolveWidget> {
  ///  Local state fields for this page.

  FFUploadedFile? image;

  String response = 'No response';

  String prompt = 'No prompt';

  bool readOnly = true;

  String? imageUrl;

  bool responding = true;

  bool imageLoad = true;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  // Stores action output result for [Backend Call - API (AZUREOCR)] action in ScanSolve widget.
  ApiCallResponse? apiResult8p1;
  // Stores action output result for [Custom Action - convertStringtoPath] action in ScanSolve widget.
  String? convertStringPath;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // Stores action output result for [Backend Call - API (AZUREOCR)] action in IconButton widget.
  ApiCallResponse? apiResult8p2;
  // Stores action output result for [Custom Action - convertStringtoPath] action in IconButton widget.
  String? convertStringPath2;
  // Stores action output result for [Backend Call - API (MathProblemSolving)] action in IconButton widget.
  ApiCallResponse? responseResult;
  // Stores action output result for [Backend Call - API (GeminiAPI)] action in IconButton widget.
  ApiCallResponse? refineOutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
