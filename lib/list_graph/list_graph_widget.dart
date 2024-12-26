import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/search_dialog_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'list_graph_model.dart';
export 'list_graph_model.dart';

class ListGraphWidget extends StatefulWidget {
  const ListGraphWidget({super.key});

  @override
  State<ListGraphWidget> createState() => _ListGraphWidgetState();
}

class _ListGraphWidgetState extends State<ListGraphWidget> {
  late ListGraphModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListGraphModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.queryGraphList = await queryGraphRecordOnce(
        queryBuilder: (graphRecord) => graphRecord
            .where(
              'createdBy',
              isEqualTo: currentUserReference,
            )
            .orderBy('createdOn', descending: true),
      );
      _model.graphList = _model.queryGraphList!.toList().cast<GraphRecord>();
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 250.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: Image.asset(
                            'assets/images/chart-illustration-collection-infographic-vector-set-data-visualization-design-elements-graphs_980716-22773-removebg-preview.png',
                          ).image,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12.0, 20.0, 0.0, 0.0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 20.0,
                        buttonSize: 40.0,
                        icon: Icon(
                          Icons.arrow_back,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          context.pushNamed('Home');
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Graphs',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  fontSize: 45.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Builder(
                                builder: (context) => FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 45.0,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  icon: const Icon(
                                    Icons.search_sharp,
                                    color: Color(0xFFFFFDFD),
                                    size: 30.0,
                                  ),
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: const AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: SearchDialogWidget(
                                              type: 'graph',
                                              onSearchChatCompleted:
                                                  (chatResults) async {},
                                              onSearchGroupCompleted:
                                                  (groupResults) async {},
                                              onSearchGraphCompleted:
                                                  (graphResults) async {
                                                _model.graphList = graphResults
                                                    .toList()
                                                    .cast<GraphRecord>();
                                                safeSetState(() {});
                                              },
                                              onSearchCalculationCompleted:
                                                  (calculationResults) async {},
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 8.0,
                                buttonSize: 45.0,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  context.pushNamed('CreateGraph1');
                                },
                              ),
                            ].divide(const SizedBox(width: 10.0)),
                          ),
                        ].divide(const SizedBox(width: 8.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 35.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Showing ${valueOrDefault<String>(
                          _model.queryGraphList?.length.toString(),
                          '0',
                        )} items.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.sort,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
                  child: Builder(
                    builder: (context) {
                      final graphListing = _model.graphList.toList();

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: graphListing.length,
                        itemBuilder: (context, graphListingIndex) {
                          final graphListingItem =
                              graphListing[graphListingIndex];
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 1.0, 0.0, 0.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12.0, 12.0, 12.0, 12.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      FFAppState().scheme =
                                          graphListingItem.colorScheme;
                                      FFAppState().showGridLines =
                                          graphListingItem.showGridLines;
                                      FFAppState().showLegend =
                                          graphListingItem.showLegend;
                                      FFAppState().showDataPoints =
                                          graphListingItem.showDataPoints;
                                      FFAppState().explodeSlices =
                                          graphListingItem.explodeSlices;
                                      FFAppState().axisLabelFontSize =
                                          graphListingItem.axisLabelsFontSize;
                                      FFAppState().titleFontSize =
                                          graphListingItem.titleFontSize;
                                      FFAppState().legendFontSize =
                                          graphListingItem.legendFontSize;
                                      FFAppState().dataPointSize =
                                          graphListingItem.dataPointSize;
                                      FFAppState().lineThickness =
                                          graphListingItem.lineThickness;
                                      FFAppState().showAxisLabels =
                                          graphListingItem.showAxisLabels;
                                      FFAppState().chartType =
                                          graphListingItem.graphType;
                                      FFAppState().chartTitle =
                                          graphListingItem.graphTitle;
                                      FFAppState().xInput =
                                          graphListingItem.xInput;
                                      FFAppState().yInput =
                                          graphListingItem.yInput;
                                      FFAppState().mode =
                                          Theme.of(context).brightness ==
                                              Brightness.dark;
                                      FFAppState().update(() {});

                                      context.pushNamed(
                                        'VisualiseGraph1',
                                        queryParameters: {
                                          'xInput': serializeParam(
                                            graphListingItem.xInput,
                                            ParamType.String,
                                          ),
                                          'graphType': serializeParam(
                                            graphListingItem.graphType,
                                            ParamType.String,
                                          ),
                                          'yInput': serializeParam(
                                            graphListingItem.yInput,
                                            ParamType.String,
                                          ),
                                          'graph': serializeParam(
                                            graphListingItem,
                                            ParamType.Document,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          'graph': graphListingItem,
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 8.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  graphListingItem.graphTitle,
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLargeFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLargeFamily),
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  4.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        functions
                                                            .convertTimestampToReadableDateTime(
                                                                graphListingItem
                                                                    .createdOn
                                                                    ?.toString()),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmallFamily,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .labelSmallFamily),
                                                                ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                          'VisualiseGraph1',
                                                          queryParameters: {
                                                            'xInput':
                                                                serializeParam(
                                                              graphListingItem
                                                                  .xInput,
                                                              ParamType.String,
                                                            ),
                                                            'graphType':
                                                                serializeParam(
                                                              graphListingItem
                                                                  .graphType,
                                                              ParamType.String,
                                                            ),
                                                            'yInput':
                                                                serializeParam(
                                                              graphListingItem
                                                                  .yInput,
                                                              ParamType.String,
                                                            ),
                                                            'graph':
                                                                serializeParam(
                                                              graphListingItem,
                                                              ParamType
                                                                  .Document,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            'graph':
                                                                graphListingItem,
                                                          },
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .chevron_right_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Opacity(
                                                  opacity: 0.8,
                                                  child: Divider(
                                                    thickness: 1.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
