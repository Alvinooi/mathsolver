import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'share_chat_widget.dart' show ShareChatWidget;
import 'package:flutter/material.dart';

class ShareChatModel extends FlutterFlowModel<ShareChatWidget> {
  ///  Local state fields for this component.

  List<UserRecord> userList = [];
  void addToUserList(UserRecord item) => userList.add(item);
  void removeFromUserList(UserRecord item) => userList.remove(item);
  void removeAtIndexFromUserList(int index) => userList.removeAt(index);
  void insertAtIndexInUserList(int index, UserRecord item) =>
      userList.insert(index, item);
  void updateUserListAtIndex(int index, Function(UserRecord) updateFn) =>
      userList[index] = updateFn(userList[index]);

  List<DocumentReference> memberList = [];
  void addToMemberList(DocumentReference item) => memberList.add(item);
  void removeFromMemberList(DocumentReference item) => memberList.remove(item);
  void removeAtIndexFromMemberList(int index) => memberList.removeAt(index);
  void insertAtIndexInMemberList(int index, DocumentReference item) =>
      memberList.insert(index, item);
  void updateMemberListAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      memberList[index] = updateFn(memberList[index]);

  List<UserRecord> selectedList = [];
  void addToSelectedList(UserRecord item) => selectedList.add(item);
  void removeFromSelectedList(UserRecord item) => selectedList.remove(item);
  void removeAtIndexFromSelectedList(int index) => selectedList.removeAt(index);
  void insertAtIndexInSelectedList(int index, UserRecord item) =>
      selectedList.insert(index, item);
  void updateSelectedListAtIndex(int index, Function(UserRecord) updateFn) =>
      selectedList[index] = updateFn(selectedList[index]);

  int index = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in ShareChat widget.
  List<UserRecord>? queryUserList;
  // Stores action output result for [Backend Call - Read Document] action in ShareChat widget.
  ChatRecord? readChatToShare;
  // Stores action output result for [Backend Call - Read Document] action in IconButton widget.
  ChatRecord? updatedMember;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  ChatRecord? readUpdateMember;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
