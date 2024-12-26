import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'create_chat_widget.dart' show CreateChatWidget;
import 'package:flutter/material.dart';

class CreateChatModel extends FlutterFlowModel<CreateChatWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for ChatName widget.
  FocusNode? chatNameFocusNode;
  TextEditingController? chatNameTextController;
  String? Function(BuildContext, String?)? chatNameTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatRecord? createChatResult;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MessageRecord? createNewPrompt;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MessageRecord? createNewResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    chatNameFocusNode?.dispose();
    chatNameTextController?.dispose();
  }
}
