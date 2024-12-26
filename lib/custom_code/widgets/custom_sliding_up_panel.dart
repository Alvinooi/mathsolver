// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import '../../components/graph_menu_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomSlidingUpPanel extends StatefulWidget {
  const CustomSlidingUpPanel({
    Key? key,
    this.width,
    this.height,
    required this.graphType,
    required this.updateGraph,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String graphType;
  final bool updateGraph;

  @override
  _CustomSlidingUpPanelState createState() => _CustomSlidingUpPanelState();
}

class _CustomSlidingUpPanelState extends State<CustomSlidingUpPanel> {
  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    double minHeight = MediaQuery.of(context).size.height * .08;
    double midHeight =
        MediaQuery.of(context).size.height * .30; // 30% for mid height
    double maxHeight = MediaQuery.of(context).size.height * .85;

    return SlidingUpPanel(
      controller: _panelController,
      minHeight: minHeight,
      maxHeight: maxHeight,
      panelSnapping: true,
      color: Colors.transparent,
      onPanelSlide: (position) {
        // Snapping logic to prevent bouncing at min height
        if (_panelController.isAttached) {
          if (position < 0.15) {
            _panelController.animatePanelToPosition(minHeight / maxHeight);
          } else if (position < 0.5) {
            _panelController.animatePanelToPosition(midHeight / maxHeight);
          } else {
            _panelController.animatePanelToPosition(1.0);
          }
        }
      },
      panel: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 15,
              left: MediaQuery.of(context).size.width * .40,
              right: MediaQuery.of(context).size.width * .40,
              child: Icon(
                Icons.maximize_outlined,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 36,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .1,
              right: 0,
              left: 0,
              child: GraphMenuWidget(
                graphType: widget.graphType,
                updateGraph: widget.updateGraph,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Delay the animation to 30% position until after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 50), () {
        _panelController
            .animatePanelToPosition(0.3); // Set to 30% as initial position
      });
    });
  }
}
