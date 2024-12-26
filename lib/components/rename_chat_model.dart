import '/flutter_flow/flutter_flow_util.dart';
import 'rename_chat_widget.dart' show RenameChatWidget;
import 'package:flutter/material.dart';

class RenameChatModel extends FlutterFlowModel<RenameChatWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for ChatName widget.
  FocusNode? chatNameFocusNode;
  TextEditingController? chatNameTextController;
  String? Function(BuildContext, String?)? chatNameTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    chatNameFocusNode?.dispose();
    chatNameTextController?.dispose();
  }
}
