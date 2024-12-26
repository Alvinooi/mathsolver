import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_group_to_chat_widget.dart' show AddGroupToChatWidget;
import 'package:flutter/material.dart';

class AddGroupToChatModel extends FlutterFlowModel<AddGroupToChatWidget> {
  ///  Local state fields for this component.

  Color selectedColour = const Color(0xfff44336);

  List<ChatRecord> addChatList = [];
  void addToAddChatList(ChatRecord item) => addChatList.add(item);
  void removeFromAddChatList(ChatRecord item) => addChatList.remove(item);
  void removeAtIndexFromAddChatList(int index) => addChatList.removeAt(index);
  void insertAtIndexInAddChatList(int index, ChatRecord item) =>
      addChatList.insert(index, item);
  void updateAddChatListAtIndex(int index, Function(ChatRecord) updateFn) =>
      addChatList[index] = updateFn(addChatList[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for CheckboxListTile widget.
  Map<ChatRecord, bool> checkboxListTileValueMap = {};
  List<ChatRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // Stores action output result for [Firestore Query - Query a collection] action in CheckboxListTile widget.
  List<ChatRecord>? updateUserChat1;
  // Stores action output result for [Firestore Query - Query a collection] action in CheckboxListTile widget.
  List<ChatRecord>? updateUserChat2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
