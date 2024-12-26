import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chat_member_widget.dart' show ChatMemberWidget;
import 'package:flutter/material.dart';

class ChatMemberModel extends FlutterFlowModel<ChatMemberWidget> {
  ///  Local state fields for this page.

  ChatRecord? chat;

  List<DocumentReference> members = [];
  void addToMembers(DocumentReference item) => members.add(item);
  void removeFromMembers(DocumentReference item) => members.remove(item);
  void removeAtIndexFromMembers(int index) => members.removeAt(index);
  void insertAtIndexInMembers(int index, DocumentReference item) =>
      members.insert(index, item);
  void updateMembersAtIndex(int index, Function(DocumentReference) updateFn) =>
      members[index] = updateFn(members[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in ChatMember widget.
  ChatRecord? readChat;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
