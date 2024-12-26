import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'calculator_widget.dart' show CalculatorWidget;
import 'package:flutter/material.dart';

class CalculatorModel extends FlutterFlowModel<CalculatorWidget> {
  ///  Local state fields for this page.

  String? expression;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in Calculator widget.
  CalculationRecord? readGraph;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
