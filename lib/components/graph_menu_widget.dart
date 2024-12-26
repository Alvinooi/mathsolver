import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'graph_menu_model.dart';
export 'graph_menu_model.dart';

class GraphMenuWidget extends StatefulWidget {
  const GraphMenuWidget({
    super.key,
    required this.graphType,
    bool? updateGraph,
  }) : updateGraph = updateGraph ?? true;

  final String? graphType;
  final bool updateGraph;

  @override
  State<GraphMenuWidget> createState() => _GraphMenuWidgetState();
}

class _GraphMenuWidgetState extends State<GraphMenuWidget> {
  late GraphMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GraphMenuModel());

    _model.switchValue1 =
        widget.updateGraph ? FFAppState().showDataPoints : false;
    _model.switchValue2 =
        widget.updateGraph ? FFAppState().showGridLines : !widget.updateGraph;
    _model.switchValue3 =
        widget.updateGraph ? FFAppState().showLegend : !widget.updateGraph;
    _model.switchValue4 = widget.updateGraph
        ? FFAppState().showAxisLabels
        : !widget.updateGraph;
    _model.switchValue5 =
        widget.updateGraph ? FFAppState().explodeSlices : !widget.updateGraph;
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Material(
      color: Colors.transparent,
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Color Scheme',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyLargeFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyLargeFamily),
                          ),
                    ),
                    Container(
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: FlutterFlowDropDown<String>(
                        controller: _model.dropDownValueController ??=
                            FormFieldController<String>(
                          _model.dropDownValue ??= widget.updateGraph
                              ? () {
                                  if (FFAppState().scheme == 'cg') {
                                    return 'Cool Gray';
                                  } else if (FFAppState().scheme == 'pr') {
                                    return 'Pastel Rainbow';
                                  } else if (FFAppState().scheme == 'dn') {
                                    return 'Dark Neon';
                                  } else if (FFAppState().scheme == 'ng') {
                                    return 'Natural Green';
                                  } else if (FFAppState().scheme == 'ob') {
                                    return 'Ocean Breeze';
                                  } else if (FFAppState().scheme == 'cb') {
                                    return 'Classic Blue';
                                  } else {
                                    return 'Cool Gray';
                                  }
                                }()
                              : 'Cool Gray',
                        ),
                        options: const [
                          'Classic Blue',
                          'Nature Green',
                          'Pastel Rainbow',
                          'Dark Neon',
                          'Cool Gray',
                          'Ocean Breeze'
                        ],
                        onChanged: (val) async {
                          safeSetState(() => _model.dropDownValue = val);
                          if (_model.dropDownValue == 'Classic Blue') {
                            FFAppState().scheme = 'cb';
                            FFAppState().update(() {});
                          } else if (_model.dropDownValue == 'Nature Green') {
                            FFAppState().scheme = 'ng';
                            FFAppState().update(() {});
                          } else if (_model.dropDownValue == 'Pastel Rainbow') {
                            FFAppState().scheme = 'pr';
                            FFAppState().update(() {});
                          } else if (_model.dropDownValue == 'Dark Neon') {
                            FFAppState().scheme = 'dn';
                            FFAppState().update(() {});
                          } else if (_model.dropDownValue == 'Ocean Breeze') {
                            FFAppState().scheme = 'ob';
                            FFAppState().update(() {});
                          } else {
                            FFAppState().scheme = 'cg';
                            FFAppState().update(() {});
                          }
                        },
                        width: 200.0,
                        height: 40.0,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                        hintText: 'Select Colour',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 2.0,
                        borderColor: Colors.transparent,
                        borderWidth: 0.0,
                        borderRadius: 8.0,
                        margin: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                    ),
                  ],
                ),
                if ((widget.graphType == 'line') ||
                    (widget.graphType == 'scatter'))
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show Data Points',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyLargeFamily),
                            ),
                      ),
                      Switch(
                        value: _model.switchValue1!,
                        onChanged: (newValue) async {
                          safeSetState(() => _model.switchValue1 = newValue);
                          if (newValue) {
                            FFAppState().showDataPoints = true;
                            FFAppState().update(() {});
                          } else {
                            FFAppState().showDataPoints = false;
                            FFAppState().update(() {});
                          }
                        },
                        activeColor: FlutterFlowTheme.of(context).primary,
                        activeTrackColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        inactiveTrackColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        inactiveThumbColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ],
                  ),
                if ((widget.graphType == 'line') ||
                    (widget.graphType == 'scatter') ||
                    (widget.graphType == 'bar'))
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show Grid Lines',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyLargeFamily),
                            ),
                      ),
                      Switch(
                        value: _model.switchValue2!,
                        onChanged: (newValue) async {
                          safeSetState(() => _model.switchValue2 = newValue);
                          if (newValue) {
                            FFAppState().showGridLines = true;
                            FFAppState().update(() {});
                          } else {
                            FFAppState().showGridLines = false;
                            FFAppState().update(() {});
                          }
                        },
                        activeColor: FlutterFlowTheme.of(context).primary,
                        activeTrackColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        inactiveTrackColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        inactiveThumbColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ],
                  ),
                if ((widget.graphType == 'pie') ||
                    (widget.graphType == 'scatter'))
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show Legend',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyLargeFamily),
                            ),
                      ),
                      Switch(
                        value: _model.switchValue3!,
                        onChanged: (newValue) async {
                          safeSetState(() => _model.switchValue3 = newValue);
                          if (newValue) {
                            FFAppState().showLegend = true;
                            FFAppState().update(() {});
                          } else {
                            FFAppState().showLegend = false;
                            FFAppState().update(() {});
                          }
                        },
                        activeColor: FlutterFlowTheme.of(context).primary,
                        activeTrackColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        inactiveTrackColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        inactiveThumbColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ],
                  ),
                if ((widget.graphType == 'line') ||
                    (widget.graphType == 'scatter') ||
                    (widget.graphType == 'bar'))
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show Axis Labels',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyLargeFamily),
                            ),
                      ),
                      Switch(
                        value: _model.switchValue4!,
                        onChanged: (newValue) async {
                          safeSetState(() => _model.switchValue4 = newValue);
                          if (newValue) {
                            FFAppState().showAxisLabels = true;
                            FFAppState().update(() {});
                          } else {
                            FFAppState().showAxisLabels = false;
                            FFAppState().update(() {});
                          }
                        },
                        activeColor: FlutterFlowTheme.of(context).primary,
                        activeTrackColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        inactiveTrackColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        inactiveThumbColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ],
                  ),
                if (widget.graphType == 'pie')
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Explode Slices',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyLargeFamily),
                            ),
                      ),
                      Switch(
                        value: _model.switchValue5!,
                        onChanged: (newValue) async {
                          safeSetState(() => _model.switchValue5 = newValue);
                          if (newValue) {
                            FFAppState().explodeSlices = true;
                            FFAppState().update(() {});
                          } else {
                            FFAppState().explodeSlices = false;
                            FFAppState().update(() {});
                          }
                        },
                        activeColor: FlutterFlowTheme.of(context).primary,
                        activeTrackColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        inactiveTrackColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        inactiveThumbColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ],
                  ),
                if ((widget.graphType == 'line') ||
                    (widget.graphType == 'bar'))
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.graphType == 'bar'
                            ? 'Bar Thickness'
                            : 'Line Thickness',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyLargeFamily),
                            ),
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                          showValueIndicator: ShowValueIndicator.always,
                        ),
                        child: Slider(
                          activeColor: FlutterFlowTheme.of(context).primary,
                          inactiveColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          min: 1.0,
                          max: 3.0,
                          value: _model.sliderValue1 ??= widget.updateGraph
                              ? () {
                                  if (FFAppState().lineThickness == 1.0) {
                                    return 1.0;
                                  } else if (FFAppState().lineThickness ==
                                      4.0) {
                                    return 3.0;
                                  } else {
                                    return 2.0;
                                  }
                                }()
                              : 2.0,
                          label: _model.sliderValue1?.toStringAsFixed(0),
                          onChanged: (newValue) async {
                            newValue =
                                double.parse(newValue.toStringAsFixed(0));
                            safeSetState(() => _model.sliderValue1 = newValue);
                            if (_model.sliderValue1 == 1.0) {
                              FFAppState().lineThickness = 1.0;
                              FFAppState().update(() {});
                            } else if (_model.sliderValue1 == 2.0) {
                              FFAppState().lineThickness = 2.0;
                              FFAppState().update(() {});
                            } else if (_model.sliderValue1 == 3.0) {
                              FFAppState().lineThickness = 4.0;
                              FFAppState().update(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                if (_model.switchValue1 == true)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Point Size',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyLargeFamily),
                            ),
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                          showValueIndicator: ShowValueIndicator.always,
                        ),
                        child: Slider(
                          activeColor: FlutterFlowTheme.of(context).primary,
                          inactiveColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          min: 1.0,
                          max: 3.0,
                          value: _model.sliderValue2 ??= widget.updateGraph
                              ? () {
                                  if (FFAppState().lineThickness == 3.0) {
                                    return 1.0;
                                  } else if (FFAppState().lineThickness ==
                                      9.0) {
                                    return 3.0;
                                  } else {
                                    return 2.0;
                                  }
                                }()
                              : 2.0,
                          label: _model.sliderValue2?.toStringAsFixed(0),
                          onChanged: (newValue) async {
                            newValue =
                                double.parse(newValue.toStringAsFixed(0));
                            safeSetState(() => _model.sliderValue2 = newValue);
                            if (_model.sliderValue2 == 1.0) {
                              FFAppState().dataPointSize = 3.0;
                              FFAppState().update(() {});
                            } else if (_model.sliderValue2 == 2.0) {
                              FFAppState().dataPointSize = 6.0;
                              FFAppState().update(() {});
                            } else if (_model.sliderValue2 == 3.0) {
                              FFAppState().dataPointSize = 9.0;
                              FFAppState().update(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                if (_model.switchValue3 == true)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Legend Font Size',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyLargeFamily),
                            ),
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                          showValueIndicator: ShowValueIndicator.always,
                        ),
                        child: Slider(
                          activeColor: FlutterFlowTheme.of(context).primary,
                          inactiveColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          min: 1.0,
                          max: 3.0,
                          value: _model.sliderValue3 ??= widget.updateGraph
                              ? () {
                                  if (FFAppState().legendFontSize == 10.0) {
                                    return 1.0;
                                  } else if (FFAppState().legendFontSize ==
                                      18.0) {
                                    return 3.0;
                                  } else {
                                    return 2.0;
                                  }
                                }()
                              : 2.0,
                          label: _model.sliderValue3?.toStringAsFixed(0),
                          onChanged: (newValue) async {
                            newValue =
                                double.parse(newValue.toStringAsFixed(0));
                            safeSetState(() => _model.sliderValue3 = newValue);
                            if (_model.sliderValue3 == 1.0) {
                              FFAppState().legendFontSize = 10.0;
                              FFAppState().update(() {});
                            } else if (_model.sliderValue3 == 2.0) {
                              FFAppState().legendFontSize = 14.0;
                              FFAppState().update(() {});
                            } else if (_model.sliderValue3 == 3.0) {
                              FFAppState().legendFontSize = 18.0;
                              FFAppState().update(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title Font Size',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyLargeFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyLargeFamily),
                          ),
                    ),
                    SliderTheme(
                      data: const SliderThemeData(
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: Slider(
                        activeColor: FlutterFlowTheme.of(context).primary,
                        inactiveColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        min: 1.0,
                        max: 3.0,
                        value: _model.sliderValue4 ??= widget.updateGraph
                            ? () {
                                if (FFAppState().titleFontSize == 16.0) {
                                  return 1.0;
                                } else if (FFAppState().titleFontSize == 24.0) {
                                  return 3.0;
                                } else {
                                  return 2.0;
                                }
                              }()
                            : 2.0,
                        label: _model.sliderValue4?.toStringAsFixed(0),
                        onChanged: (newValue) async {
                          newValue = double.parse(newValue.toStringAsFixed(0));
                          safeSetState(() => _model.sliderValue4 = newValue);
                          if (_model.sliderValue4 == 1.0) {
                            FFAppState().titleFontSize = 16.0;
                            FFAppState().update(() {});
                          } else if (_model.sliderValue4 == 2.0) {
                            FFAppState().titleFontSize = 20.0;
                            FFAppState().update(() {});
                          } else if (_model.sliderValue4 == 3.0) {
                            FFAppState().titleFontSize = 24.0;
                            FFAppState().update(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
                if (_model.switchValue4 == true)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Axis Label Font Size',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyLargeFamily),
                            ),
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                          showValueIndicator: ShowValueIndicator.always,
                        ),
                        child: Slider(
                          activeColor: FlutterFlowTheme.of(context).primary,
                          inactiveColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          min: 1.0,
                          max: 3.0,
                          value: _model.sliderValue5 ??= widget.updateGraph
                              ? () {
                                  if (FFAppState().axisLabelFontSize == 12.0) {
                                    return 1.0;
                                  } else if (FFAppState().axisLabelFontSize ==
                                      20.0) {
                                    return 3.0;
                                  } else {
                                    return 2.0;
                                  }
                                }()
                              : 2.0,
                          label: _model.sliderValue5?.toStringAsFixed(0),
                          onChanged: (newValue) async {
                            newValue =
                                double.parse(newValue.toStringAsFixed(0));
                            safeSetState(() => _model.sliderValue5 = newValue);
                            if (_model.sliderValue5 == 1.0) {
                              FFAppState().axisLabelFontSize = 12.0;
                              FFAppState().update(() {});
                            } else if (_model.sliderValue5 == 2.0) {
                              FFAppState().axisLabelFontSize = 16.0;
                              FFAppState().update(() {});
                            } else if (_model.sliderValue5 == 3.0) {
                              FFAppState().axisLabelFontSize = 20.0;
                              FFAppState().update(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
              ].divide(const SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
