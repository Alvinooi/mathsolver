import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'list_graph_widget.dart' show ListGraphWidget;
import 'package:flutter/material.dart';

class ListGraphModel extends FlutterFlowModel<ListGraphWidget> {
  ///  Local state fields for this page.

  String status = '';

  List<GraphRecord> graphList = [];
  void addToGraphList(GraphRecord item) => graphList.add(item);
  void removeFromGraphList(GraphRecord item) => graphList.remove(item);
  void removeAtIndexFromGraphList(int index) => graphList.removeAt(index);
  void insertAtIndexInGraphList(int index, GraphRecord item) =>
      graphList.insert(index, item);
  void updateGraphListAtIndex(int index, Function(GraphRecord) updateFn) =>
      graphList[index] = updateFn(graphList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in ListGraph widget.
  List<GraphRecord>? queryGraphList;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
