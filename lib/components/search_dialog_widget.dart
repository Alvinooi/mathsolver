import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_search/text_search.dart';
import 'search_dialog_model.dart';
export 'search_dialog_model.dart';

class SearchDialogWidget extends StatefulWidget {
  const SearchDialogWidget({
    super.key,
    this.onSearchChatCompleted,
    required this.type,
    this.onSearchGroupCompleted,
    this.onSearchGraphCompleted,
    this.onSearchCalculationCompleted,
  });

  final Future Function(List<ChatRecord> chatResults)? onSearchChatCompleted;
  final String? type;
  final Future Function(List<ChatGroupRecord> groupResults)?
      onSearchGroupCompleted;
  final Future Function(List<GraphRecord> graphResults)? onSearchGraphCompleted;
  final Future Function(List<CalculationRecord> calculationResults)?
      onSearchCalculationCompleted;

  @override
  State<SearchDialogWidget> createState() => _SearchDialogWidgetState();
}

class _SearchDialogWidgetState extends State<SearchDialogWidget> {
  late SearchDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchDialogModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.readChatGroups = await queryChatGroupRecordOnce(
        queryBuilder: (chatGroupRecord) => chatGroupRecord
            .where(
              'createdBy',
              isEqualTo: currentUserReference,
            )
            .orderBy('groupName'),
      );
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Search',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .headlineSmallFamily),
                                ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.close_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Search Term',
                                style: FlutterFlowTheme.of(context)
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
                              ),
                              SizedBox(
                                width: 250.0,
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: FlutterFlowTheme.of(context)
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
                                    hintText: 'Search....',
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
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  style: FlutterFlowTheme.of(context)
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
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ].divide(const SizedBox(height: 5.0)),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              safeSetState(() {
                                _model.textController?.clear();
                              });
                            },
                            text: 'Clear',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
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
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ].divide(const SizedBox(width: 7.0)),
                      ),
                      if ((widget.type == 'chat') &&
                          (_model.readChatGroups != null &&
                              (_model.readChatGroups)!.isNotEmpty))
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chat Groups',
                              style: FlutterFlowTheme.of(context)
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
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController1 ??=
                                  FormFieldController<String>(
                                _model.dropDownValue1 ??= '0',
                              ),
                              options: List<String>.from(_model.readChatGroups!
                                  .map((e) => e.reference.id)
                                  .toList()),
                              optionLabels: _model.readChatGroups!
                                  .map((e) => e.groupName)
                                  .toList(),
                              onChanged: (val) async {
                                safeSetState(() => _model.dropDownValue1 = val);
                                _model.getGroupDoc =
                                    await actions.getDocRefFromID(
                                  '',
                                );
                                _model.chatGroup = _model.getGroupDoc;
                                safeSetState(() {});

                                safeSetState(() {});
                              },
                              width: double.infinity,
                              height: 40.0,
                              searchHintTextStyle: FlutterFlowTheme.of(context)
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
                              searchTextStyle: FlutterFlowTheme.of(context)
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
                              hintText: 'Select...',
                              searchHintText: 'Search...',
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              elevation: 2.0,
                              borderColor: Colors.transparent,
                              borderWidth: 0.0,
                              borderRadius: 8.0,
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: true,
                              isMultiSelect: false,
                            ),
                          ].divide(const SizedBox(height: 5.0)),
                        ),
                      if (widget.type == 'graph')
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Graph Type',
                              style: FlutterFlowTheme.of(context)
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
                            ),
                            FlutterFlowDropDown<String>(
                              multiSelectController:
                                  _model.dropDownValueController2 ??=
                                      FormListFieldController<String>(null),
                              options: List<String>.from(
                                  ['pie', 'bar', 'line', 'scatter', 'math']),
                              optionLabels: const [
                                'Pie',
                                'Bar',
                                'Line',
                                'Sactter',
                                'Mathematical'
                              ],
                              width: double.infinity,
                              height: 40.0,
                              searchHintTextStyle: FlutterFlowTheme.of(context)
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
                              searchTextStyle: FlutterFlowTheme.of(context)
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
                              hintText: 'Select...',
                              searchHintText: 'Search...',
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              elevation: 2.0,
                              borderColor: Colors.transparent,
                              borderWidth: 0.0,
                              borderRadius: 8.0,
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: true,
                              isMultiSelect: true,
                              onMultiSelectChanged: (val) => safeSetState(
                                  () => _model.dropDownValue2 = val),
                            ),
                          ].divide(const SizedBox(height: 5.0)),
                        ),
                      Stack(
                        children: [
                          if (widget.type == 'chat')
                            FFButtonWidget(
                              onPressed: () async {
                                if ((widget.type == 'chat') &&
                                    (_model.readChatGroups != null &&
                                        (_model.readChatGroups)!.isNotEmpty)) {
                                  _model.getGroup =
                                      await actions.getDocRefFromID(
                                    _model.dropDownValue1!,
                                  );
                                  _model.querySearchChat1 =
                                      await queryChatRecordOnce(
                                    queryBuilder: (chatRecord) => chatRecord
                                        .where(
                                          'createdBy',
                                          isEqualTo: currentUserReference,
                                        )
                                        .where(
                                          'status',
                                          isEqualTo: 'Active',
                                        )
                                        .where(
                                          'groupID',
                                          isEqualTo: _model.getGroup,
                                        ),
                                  );
                                  _model.chatList = _model.querySearchChat1!
                                      .toList()
                                      .cast<ChatRecord>();
                                  safeSetState(() {});
                                } else {
                                  _model.querySearchChat2 =
                                      await queryChatRecordOnce(
                                    queryBuilder: (chatRecord) => chatRecord
                                        .where(
                                          'createdBy',
                                          isEqualTo: currentUserReference,
                                        )
                                        .where(
                                          'status',
                                          isEqualTo: 'Active',
                                        ),
                                  );
                                  _model.chatList = _model.querySearchChat2!
                                      .toList()
                                      .cast<ChatRecord>();
                                  safeSetState(() {});
                                }

                                safeSetState(() {
                                  _model.simpleSearchResults1 = TextSearch(
                                    _model.chatList
                                        .map(
                                          (record) => TextSearchItem.fromTerms(
                                              record, [record.chatName]),
                                        )
                                        .toList(),
                                  )
                                      .search(_model.textController.text)
                                      .map((r) => r.object)
                                      .toList();
                                });
                                await widget.onSearchChatCompleted?.call(
                                  _model.simpleSearchResults1,
                                );
                                Navigator.pop(context);

                                safeSetState(() {});
                              },
                              text: 'Apply Filter',
                              options: FFButtonOptions(
                                width: double.infinity,
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
                                      color: FlutterFlowTheme.of(context).info,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          if (widget.type == 'graph')
                            FFButtonWidget(
                              onPressed: () async {
                                _model.queryGraphChat =
                                    await queryGraphRecordOnce(
                                  queryBuilder: (graphRecord) => graphRecord
                                      .where(
                                        'createdBy',
                                        isEqualTo: currentUserReference,
                                      )
                                      .whereIn(
                                          'graphType', _model.dropDownValue2),
                                );
                                safeSetState(() {
                                  _model.simpleSearchResults2 = TextSearch(
                                    _model.queryGraphChat!
                                        .map(
                                          (record) => TextSearchItem.fromTerms(
                                              record, [record.graphTitle]),
                                        )
                                        .toList(),
                                  )
                                      .search(_model.textController.text)
                                      .map((r) => r.object)
                                      .toList();
                                });
                                await widget.onSearchGraphCompleted?.call(
                                  _model.simpleSearchResults2,
                                );

                                safeSetState(() {});
                              },
                              text: 'Apply Filter',
                              options: FFButtonOptions(
                                width: double.infinity,
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
                                      color: FlutterFlowTheme.of(context).info,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          if (widget.type == 'calculation')
                            FFButtonWidget(
                              onPressed: () async {
                                _model.queryCalculationChat =
                                    await queryCalculationRecordOnce(
                                  queryBuilder: (calculationRecord) =>
                                      calculationRecord.where(
                                    'createdBy',
                                    isEqualTo: currentUserReference,
                                  ),
                                );
                                safeSetState(() {
                                  _model.simpleSearchResults3 = TextSearch(
                                    _model.queryCalculationChat!
                                        .map(
                                          (record) => TextSearchItem.fromTerms(
                                              record, [record.expression]),
                                        )
                                        .toList(),
                                  )
                                      .search(_model.textController.text)
                                      .map((r) => r.object)
                                      .toList();
                                });
                                await widget.onSearchCalculationCompleted?.call(
                                  _model.simpleSearchResults3,
                                );

                                safeSetState(() {});
                              },
                              text: 'Apply Filter',
                              options: FFButtonOptions(
                                width: double.infinity,
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
                                      color: FlutterFlowTheme.of(context).info,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          if (widget.type == 'group')
                            FFButtonWidget(
                              onPressed: () async {
                                _model.queryGroupChat =
                                    await queryChatGroupRecordOnce(
                                  queryBuilder: (chatGroupRecord) =>
                                      chatGroupRecord.where(
                                    'createdBy',
                                    isEqualTo: currentUserReference,
                                  ),
                                );
                                safeSetState(() {
                                  _model.simpleSearchResults4 = TextSearch(
                                    _model.queryGroupChat!
                                        .map(
                                          (record) => TextSearchItem.fromTerms(
                                              record, [record.groupName]),
                                        )
                                        .toList(),
                                  )
                                      .search(_model.textController.text)
                                      .map((r) => r.object)
                                      .toList();
                                });
                                await widget.onSearchGroupCompleted?.call(
                                  _model.simpleSearchResults4,
                                );

                                safeSetState(() {});
                              },
                              text: 'Apply Filter',
                              options: FFButtonOptions(
                                width: double.infinity,
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
                                      color: FlutterFlowTheme.of(context).info,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily),
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                        ],
                      ),
                    ].divide(const SizedBox(height: 16.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
