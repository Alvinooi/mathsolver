import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'group_widget.dart' show GroupWidget;
import 'package:flutter/material.dart';

class GroupModel extends FlutterFlowModel<GroupWidget> {
  ///  Local state fields for this page.

  List<ChatRecord> chatList = [];
  void addToChatList(ChatRecord item) => chatList.add(item);
  void removeFromChatList(ChatRecord item) => chatList.remove(item);
  void removeAtIndexFromChatList(int index) => chatList.removeAt(index);
  void insertAtIndexInChatList(int index, ChatRecord item) =>
      chatList.insert(index, item);
  void updateChatListAtIndex(int index, Function(ChatRecord) updateFn) =>
      chatList[index] = updateFn(chatList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in Group widget.
  ChatGroupRecord? readGroupResults;
  // Stores action output result for [Firestore Query - Query a collection] action in Group widget.
  List<ChatRecord>? readChatMessages;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
