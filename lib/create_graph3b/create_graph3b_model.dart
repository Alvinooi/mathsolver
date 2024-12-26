import '/flutter_flow/flutter_flow_util.dart';
import 'create_graph3b_widget.dart' show CreateGraph3bWidget;
import 'package:flutter/material.dart';

class CreateGraph3bModel extends FlutterFlowModel<CreateGraph3bWidget> {
  ///  Local state fields for this page.

  bool? validationField1;

  bool? validationField2;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
