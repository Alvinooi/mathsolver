import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'search_dialog_widget.dart' show SearchDialogWidget;
import 'package:flutter/material.dart';

class SearchDialogModel extends FlutterFlowModel<SearchDialogWidget> {
  ///  Local state fields for this component.

  List<ChatGroupRecord> groupList = [];
  void addToGroupList(ChatGroupRecord item) => groupList.add(item);
  void removeFromGroupList(ChatGroupRecord item) => groupList.remove(item);
  void removeAtIndexFromGroupList(int index) => groupList.removeAt(index);
  void insertAtIndexInGroupList(int index, ChatGroupRecord item) =>
      groupList.insert(index, item);
  void updateGroupListAtIndex(int index, Function(ChatGroupRecord) updateFn) =>
      groupList[index] = updateFn(groupList[index]);

  DocumentReference? chatGroup;

  List<ChatRecord> chatList = [];
  void addToChatList(ChatRecord item) => chatList.add(item);
  void removeFromChatList(ChatRecord item) => chatList.remove(item);
  void removeAtIndexFromChatList(int index) => chatList.removeAt(index);
  void insertAtIndexInChatList(int index, ChatRecord item) =>
      chatList.insert(index, item);
  void updateChatListAtIndex(int index, Function(ChatRecord) updateFn) =>
      chatList[index] = updateFn(chatList[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in SearchDialog widget.
  List<ChatGroupRecord>? readChatGroups;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // Stores action output result for [Custom Action - getDocRefFromID] action in DropDown widget.
  DocumentReference? getGroupDoc;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue2;
  FormFieldController<List<String>>? dropDownValueController2;
  // Stores action output result for [Custom Action - getDocRefFromID] action in Button widget.
  DocumentReference? getGroup;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<ChatRecord>? querySearchChat1;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<ChatRecord>? querySearchChat2;
  List<ChatRecord> simpleSearchResults1 = [];
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<GraphRecord>? queryGraphChat;
  List<GraphRecord> simpleSearchResults2 = [];
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<CalculationRecord>? queryCalculationChat;
  List<CalculationRecord> simpleSearchResults3 = [];
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<ChatGroupRecord>? queryGroupChat;
  List<ChatGroupRecord> simpleSearchResults4 = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
