import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'create_group_widget.dart' show CreateGroupWidget;
import 'package:flutter/material.dart';

class CreateGroupModel extends FlutterFlowModel<CreateGroupWidget> {
  ///  Local state fields for this component.

  Color selectedColour = const Color(0xfff44336);

  ///  State fields for stateful widgets in this component.

  // State field(s) for ChatName widget.
  FocusNode? chatNameFocusNode;
  TextEditingController? chatNameTextController;
  String? Function(BuildContext, String?)? chatNameTextControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatGroupRecord? createGroupResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    chatNameFocusNode?.dispose();
    chatNameTextController?.dispose();
  }
}
