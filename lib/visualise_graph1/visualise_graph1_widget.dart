import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'visualise_graph1_model.dart';
export 'visualise_graph1_model.dart';

class VisualiseGraph1Widget extends StatefulWidget {
  /// allow the user to customise the graph
  const VisualiseGraph1Widget({
    super.key,
    this.xInput,
    required this.graphType,
    this.yInput,
    this.graph,
  });

  final String? xInput;
  final String? graphType;
  final String? yInput;
  final GraphRecord? graph;

  @override
  State<VisualiseGraph1Widget> createState() => _VisualiseGraph1WidgetState();
}

class _VisualiseGraph1WidgetState extends State<VisualiseGraph1Widget> {
  late VisualiseGraph1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VisualiseGraph1Model());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.graph != null) {
        _model.readGraph =
            await GraphRecord.getDocumentOnce(widget.graph!.reference);
        _model.updateGraph = true;
        safeSetState(() {});
        FFAppState().scheme = _model.readGraph!.colorScheme;
        FFAppState().showGridLines = _model.readGraph!.showGridLines;
        FFAppState().showLegend = _model.readGraph!.showLegend;
        FFAppState().showDataPoints = _model.readGraph!.showDataPoints;
        FFAppState().explodeSlices = _model.readGraph!.explodeSlices;
        FFAppState().axisLabelFontSize = _model.readGraph!.axisLabelsFontSize;
        FFAppState().titleFontSize = _model.readGraph!.titleFontSize;
        FFAppState().legendFontSize = _model.readGraph!.legendFontSize;
        FFAppState().dataPointSize = _model.readGraph!.dataPointSize;
        FFAppState().lineThickness = _model.readGraph!.lineThickness;
        FFAppState().showAxisLabels = _model.readGraph!.showAxisLabels;
        FFAppState().xInput = _model.readGraph!.xInput;
        FFAppState().yInput = _model.readGraph!.yInput;
        FFAppState().chartType = _model.readGraph!.graphType;
        FFAppState().chartTitle = _model.readGraph!.graphTitle;
        FFAppState().update(() {});
      } else {
        FFAppState().chartTitle = 'Untitled Graph';
        FFAppState().showDataPoints = true;
        FFAppState().update(() {});
      }
    });

    _model.textController1 ??=
        TextEditingController(text: FFAppState().chartTitle);
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController(text: FFAppState().xInput);
    _model.textFieldFocusNode2 ??= FocusNode();
    _model.textFieldFocusNode2!.addListener(
      () async {
        FFAppState().xInput = _model.textController2.text;
        FFAppState().update(() {});
      },
    );
    _model.textController3 ??= TextEditingController(text: FFAppState().yInput);
    _model.textFieldFocusNode3 ??= FocusNode();
    _model.textFieldFocusNode3!.addListener(
      () async {
        FFAppState().yInput = _model.textController3.text;
        FFAppState().update(() {});
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              if (widget.graph != null) {
                context.pushNamed('ListGraph');
              } else {
                context.safePop();
              }
            },
          ),
          title: Text(
            FFAppState().chartTitle,
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).titleLargeFamily),
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20.0, 20.0, 0.0, 0.0),
                            child: SizedBox(
                              width: 350.0,
                              child: TextFormField(
                                controller: _model.textController1,
                                focusNode: _model.textFieldFocusNode1,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.textController1',
                                  const Duration(milliseconds: 2000),
                                  () async {
                                    FFAppState().chartTitle =
                                        _model.textController1.text;
                                    FFAppState().update(() {});
                                  },
                                ),
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Title',
                                  hintText: 'Title',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                textAlign: TextAlign.start,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model.textController1Validator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 2.0,
                            height: 400.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 600.0,
                              child: custom_widgets.ChartDisplayWidget(
                                width: double.infinity,
                                height: 600.0,
                                title: widget.graph != null
                                    ? FFAppState().chartTitle
                                    : 'Untitled Graph',
                                scheme: FFAppState().scheme,
                                lineThickness: FFAppState().lineThickness,
                                dataPointSize: FFAppState().dataPointSize,
                                chartType: FFAppState().chartType,
                                showDataPoints: FFAppState().showDataPoints,
                                showGridLines: FFAppState().showGridLines,
                                showAxisLabels: FFAppState().showAxisLabels,
                                showLegend: FFAppState().showLegend,
                                explodeSlices: FFAppState().explodeSlices,
                                titleFontSize: FFAppState().titleFontSize,
                                axisLabelFontSize:
                                    FFAppState().axisLabelFontSize,
                                legendFontSize: FFAppState().legendFontSize,
                                xInput: FFAppState().xInput,
                                yInput: FFAppState().yInput,
                                mode: Theme.of(context).brightness ==
                                    Brightness.dark,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              18.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chart Type',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineSmallFamily,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmallFamily),
                                    ),
                              ),
                              FlutterFlowDropDown<String>(
                                controller: _model.dropDownValueController ??=
                                    FormFieldController<String>(
                                  _model.dropDownValue ??= () {
                                    if (FFAppState().chartType == 'pie') {
                                      return 'Pie';
                                    } else if (FFAppState().chartType ==
                                        'line') {
                                      return 'Line';
                                    } else if (FFAppState().chartType ==
                                        'scatter') {
                                      return 'Scatter';
                                    } else if (FFAppState().chartType ==
                                        'math') {
                                      return 'Mathematical';
                                    } else if (FFAppState().chartType ==
                                        'bar') {
                                      return 'Bar';
                                    } else {
                                      return '';
                                    }
                                  }(),
                                ),
                                options: const [
                                  'Pie',
                                  'Line',
                                  'Bar',
                                  'Scatter',
                                  'Mathematical'
                                ],
                                onChanged: (val) async {
                                  safeSetState(
                                      () => _model.dropDownValue = val);
                                  if (_model.dropDownValue == 'Mathematical') {
                                    FFAppState().chartType = 'math';
                                    FFAppState().update(() {});
                                  } else {
                                    if (_model.dropDownValue == 'Pie') {
                                      FFAppState().chartType = 'pie';
                                      FFAppState().update(() {});
                                    } else if (_model.dropDownValue == 'Bar') {
                                      FFAppState().chartType = 'bar';
                                      FFAppState().update(() {});
                                    } else if (_model.dropDownValue ==
                                        'Scatter') {
                                      FFAppState().chartType = 'scatter';
                                      FFAppState().update(() {});
                                    } else {
                                      FFAppState().chartType = 'line';
                                      FFAppState().update(() {});
                                    }
                                  }
                                },
                                width: 350.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                                hintText: 'Select Chart Type',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
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
                            ].divide(const SizedBox(height: 8.0)),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 0.0, 0.0),
                              child: Text(
                                FFAppState().chartType == 'math'
                                    ? 'Equation'
                                    : 'X Input Data',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineSmallFamily,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmallFamily),
                                    ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: SizedBox(
                                  width: 350.0,
                                  child: TextFormField(
                                    controller: _model.textController2,
                                    focusNode: _model.textFieldFocusNode2,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.textController2',
                                      const Duration(milliseconds: 2000),
                                      () async {
                                        FFAppState().xInput =
                                            _model.textController2.text;
                                        FFAppState().update(() {});
                                      },
                                    ),
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'X Input',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily),
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                        ),
                                    textAlign: TextAlign.start,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model.textController2Validator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(const SizedBox(height: 8.0)),
                        ),
                        if (FFAppState().chartType != 'math')
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Y Input Data',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineSmallFamily,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .headlineSmallFamily),
                                      ),
                                ),
                              ),
                              if (FFAppState().chartType != 'math')
                                Align(
                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 0.0, 0.0),
                                    child: SizedBox(
                                      width: 350.0,
                                      child: TextFormField(
                                        controller: _model.textController3,
                                        focusNode: _model.textFieldFocusNode3,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.textController3',
                                          const Duration(milliseconds: 2000),
                                          () async {
                                            FFAppState().yInput =
                                                _model.textController3.text;
                                            FFAppState().update(() {});
                                          },
                                        ),
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: 'Title',
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumFamily),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                            ),
                                        textAlign: TextAlign.start,
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        validator: _model
                                            .textController3Validator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ),
                            ].divide(const SizedBox(height: 8.0)),
                          ),
                        SizedBox(
                          width: double.infinity,
                          height: 500.0,
                          child: custom_widgets.DataAnalyse(
                            width: double.infinity,
                            height: 500.0,
                            xInput: FFAppState().xInput,
                            yInput: FFAppState().yInput,
                            type: FFAppState().chartType,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                if (widget.graph != null) {
                                  await widget.graph!.reference.update({
                                    ...createGraphRecordData(
                                      graphTitle: FFAppState().chartTitle,
                                      colorScheme: FFAppState().scheme,
                                      showLegend: FFAppState().showLegend,
                                      showDataPoints:
                                          FFAppState().showDataPoints,
                                      showAxisLabels:
                                          FFAppState().showAxisLabels,
                                      lineThickness: FFAppState().lineThickness,
                                      dataPointSize: FFAppState().dataPointSize,
                                      explodeSlices: FFAppState().explodeSlices,
                                      titleFontSize: FFAppState().titleFontSize,
                                      axisLabelsFontSize:
                                          FFAppState().axisLabelFontSize,
                                      legendFontSize:
                                          FFAppState().legendFontSize,
                                      showGridLines: FFAppState().showGridLines,
                                      xInput: FFAppState().xInput,
                                      yInput: FFAppState().chartType != 'math'
                                          ? FFAppState().yInput
                                          : '-',
                                      graphType: FFAppState().chartType,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'updatedOn':
                                            FieldValue.serverTimestamp(),
                                      },
                                    ),
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Graph updated.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: const Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                    ),
                                  );
                                } else {
                                  var graphRecordReference =
                                      GraphRecord.collection.doc();
                                  await graphRecordReference.set({
                                    ...createGraphRecordData(
                                      graphTitle: FFAppState().chartTitle,
                                      colorScheme: FFAppState().scheme,
                                      showLegend: FFAppState().showLegend,
                                      showDataPoints:
                                          FFAppState().showDataPoints,
                                      showAxisLabels:
                                          FFAppState().showAxisLabels,
                                      lineThickness: FFAppState().lineThickness,
                                      dataPointSize: FFAppState().dataPointSize,
                                      explodeSlices: FFAppState().explodeSlices,
                                      titleFontSize: FFAppState().titleFontSize,
                                      axisLabelsFontSize:
                                          FFAppState().axisLabelFontSize,
                                      legendFontSize:
                                          FFAppState().legendFontSize,
                                      showGridLines: FFAppState().showGridLines,
                                      createdBy: currentUserReference,
                                      xInput: FFAppState().xInput,
                                      yInput: FFAppState().yInput,
                                      graphType: FFAppState().chartType,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'createdOn':
                                            FieldValue.serverTimestamp(),
                                        'updatedOn':
                                            FieldValue.serverTimestamp(),
                                      },
                                    ),
                                  });
                                  _model.createGraph =
                                      GraphRecord.getDocumentFromData({
                                    ...createGraphRecordData(
                                      graphTitle: FFAppState().chartTitle,
                                      colorScheme: FFAppState().scheme,
                                      showLegend: FFAppState().showLegend,
                                      showDataPoints:
                                          FFAppState().showDataPoints,
                                      showAxisLabels:
                                          FFAppState().showAxisLabels,
                                      lineThickness: FFAppState().lineThickness,
                                      dataPointSize: FFAppState().dataPointSize,
                                      explodeSlices: FFAppState().explodeSlices,
                                      titleFontSize: FFAppState().titleFontSize,
                                      axisLabelsFontSize:
                                          FFAppState().axisLabelFontSize,
                                      legendFontSize:
                                          FFAppState().legendFontSize,
                                      showGridLines: FFAppState().showGridLines,
                                      createdBy: currentUserReference,
                                      xInput: FFAppState().xInput,
                                      yInput: FFAppState().yInput,
                                      graphType: FFAppState().chartType,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'createdOn': DateTime.now(),
                                        'updatedOn': DateTime.now(),
                                      },
                                    ),
                                  }, graphRecordReference);
                                  if (_model.createGraph?.reference != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Graph successfully saved!',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: const Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Error occured. Graph not saved. Please try again.',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: const Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                      ),
                                    );
                                  }
                                }

                                safeSetState(() {});
                              },
                              text: 'Save Graph',
                              options: FFButtonOptions(
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                height: 50.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (FFAppState().chartType != 'math')
                              FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    'GraphCustomisation',
                                    queryParameters: {
                                      'graphType': serializeParam(
                                        FFAppState().chartType,
                                        ParamType.String,
                                      ),
                                      'updateGraph': serializeParam(
                                        _model.updateGraph,
                                        ParamType.bool,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                text: 'Customise',
                                options: FFButtonOptions(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height: 50.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily),
                                      ),
                                  elevation: 2.0,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed('Home');
                              },
                              text: 'Back To Home',
                              options: FFButtonOptions(
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                height: 50.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ],
                        ),
                      ].divide(const SizedBox(height: 24.0)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
