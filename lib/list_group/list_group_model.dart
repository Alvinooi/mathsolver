import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'list_group_widget.dart' show ListGroupWidget;
import 'package:flutter/material.dart';

class ListGroupModel extends FlutterFlowModel<ListGroupWidget> {
  ///  Local state fields for this page.

  String status = '';

  List<ChatGroupRecord> groupList = [];
  void addToGroupList(ChatGroupRecord item) => groupList.add(item);
  void removeFromGroupList(ChatGroupRecord item) => groupList.remove(item);
  void removeAtIndexFromGroupList(int index) => groupList.removeAt(index);
  void insertAtIndexInGroupList(int index, ChatGroupRecord item) =>
      groupList.insert(index, item);
  void updateGroupListAtIndex(int index, Function(ChatGroupRecord) updateFn) =>
      groupList[index] = updateFn(groupList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in ListGroup widget.
  List<ChatGroupRecord>? queryGroupList;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
