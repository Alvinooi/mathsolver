import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'other_profile_widget.dart' show OtherProfileWidget;
import 'package:flutter/material.dart';

class OtherProfileModel extends FlutterFlowModel<OtherProfileWidget> {
  ///  Local state fields for this page.

  List<ChatRecord> commonChats = [];
  void addToCommonChats(ChatRecord item) => commonChats.add(item);
  void removeFromCommonChats(ChatRecord item) => commonChats.remove(item);
  void removeAtIndexFromCommonChats(int index) => commonChats.removeAt(index);
  void insertAtIndexInCommonChats(int index, ChatRecord item) =>
      commonChats.insert(index, item);
  void updateCommonChatsAtIndex(int index, Function(ChatRecord) updateFn) =>
      commonChats[index] = updateFn(commonChats[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in OtherProfile widget.
  List<ChatRecord>? profileChatQuery;
  // Stores action output result for [Firestore Query - Query a collection] action in OtherProfile widget.
  List<ChatRecord>? userChatQuery;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
