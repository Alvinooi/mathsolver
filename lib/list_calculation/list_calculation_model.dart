import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'list_calculation_widget.dart' show ListCalculationWidget;
import 'package:flutter/material.dart';

class ListCalculationModel extends FlutterFlowModel<ListCalculationWidget> {
  ///  Local state fields for this page.

  String status = '';

  List<CalculationRecord> calculationList = [];
  void addToCalculationList(CalculationRecord item) =>
      calculationList.add(item);
  void removeFromCalculationList(CalculationRecord item) =>
      calculationList.remove(item);
  void removeAtIndexFromCalculationList(int index) =>
      calculationList.removeAt(index);
  void insertAtIndexInCalculationList(int index, CalculationRecord item) =>
      calculationList.insert(index, item);
  void updateCalculationListAtIndex(
          int index, Function(CalculationRecord) updateFn) =>
      calculationList[index] = updateFn(calculationList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in ListCalculation widget.
  List<CalculationRecord>? queryCalculationList;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
