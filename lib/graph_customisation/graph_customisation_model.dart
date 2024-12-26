import '/components/graph_menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'graph_customisation_widget.dart' show GraphCustomisationWidget;
import 'package:flutter/material.dart';

class GraphCustomisationModel
    extends FlutterFlowModel<GraphCustomisationWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for GraphMenu component.
  late GraphMenuModel graphMenuModel;

  @override
  void initState(BuildContext context) {
    graphMenuModel = createModel(context, () => GraphMenuModel());
  }

  @override
  void dispose() {
    graphMenuModel.dispose();
  }
}
