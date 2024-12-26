import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'list_chat_widget.dart' show ListChatWidget;
import 'package:flutter/material.dart';

class ListChatModel extends FlutterFlowModel<ListChatWidget> {
  ///  Local state fields for this page.

  String status = '';

  List<ChatRecord> chatList = [];
  void addToChatList(ChatRecord item) => chatList.add(item);
  void removeFromChatList(ChatRecord item) => chatList.remove(item);
  void removeAtIndexFromChatList(int index) => chatList.removeAt(index);
  void insertAtIndexInChatList(int index, ChatRecord item) =>
      chatList.insert(index, item);
  void updateChatListAtIndex(int index, Function(ChatRecord) updateFn) =>
      chatList[index] = updateFn(chatList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in ListChat widget.
  List<ChatRecord>? queryChatAccess;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
