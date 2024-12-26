import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/crop_image_widget.dart';
import '/components/dropdown1_widget.dart';
import '/components/dropdown2_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_search/text_search.dart';
import 'chat_model.dart';
export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
    required this.chat,
    this.messagesList,
    required this.home,
    this.url,
  });

  final DocumentReference? chat;
  final List<MessageRecord>? messagesList;
  final bool? home;
  final String? url;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.responding = false;
      safeSetState(() {});
      if (widget.home!) {
        _model.search = false;
        safeSetState(() {});
        _model.apiResults75 = await AzureocrCall.call(
          url: widget.url,
        );

        if ((_model.apiResults75?.succeeded ?? true)) {
          if (AzureocrCall.description(
                    (_model.apiResults75?.jsonBody ?? ''),
                  ) !=
                  null &&
              AzureocrCall.description(
                    (_model.apiResults75?.jsonBody ?? ''),
                  ) !=
                  '') {
            safeSetState(() {
              _model.textController2?.text = AzureocrCall.description(
                (_model.apiResults75?.jsonBody ?? ''),
              )!;
            });
          } else {
            await showDialog(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Result empty'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: const Text('Ok'),
                    ),
                  ],
                );
              },
            );
          }
        }
      } else {
        _model.search = false;
        safeSetState(() {});
        _model.readChatResults =
            await ChatRecord.getDocumentOnce(widget.chat!);
        _model.readChatMessages = await queryMessageRecordOnce(
          queryBuilder: (messageRecord) => messageRecord
              .where(
                'chat',
                isEqualTo: widget.chat,
              )
              .orderBy('createdOn'),
        );
        _model.messages =
            _model.readChatMessages!.toList().cast<MessageRecord>();
        safeSetState(() {});
        await _model.listViewController1?.animateTo(
          _model.listViewController1!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease,
        );
        if (!(_model.readChatResults != null)) {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Chat Not Found'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        }
      }
    });

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              elevation: 2.0,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 20.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.arrow_back,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.pushNamed('ListChat');
                            },
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 300.0,
                                child: Stack(
                                  children: [
                                    if (_model.search == true)
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 200.0,
                                            child: TextFormField(
                                              controller:
                                                  _model.textController1,
                                              focusNode:
                                                  _model.textFieldFocusNode1,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily),
                                                        ),
                                                hintText: 'TextField',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMediumFamily),
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              validator: _model
                                                  .textController1Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderRadius: 20.0,
                                            buttonSize: 40.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            icon: const Icon(
                                              Icons.search,
                                              color: Colors.white,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              safeSetState(() {
                                                _model.simpleSearchResults =
                                                    TextSearch(
                                                  widget.messagesList!
                                                      .map(
                                                        (record) =>
                                                            TextSearchItem
                                                                .fromTerms(
                                                                    record, [
                                                          record.content
                                                        ]),
                                                      )
                                                      .toList(),
                                                )
                                                        .search(_model
                                                            .textController1
                                                            .text)
                                                        .map((r) => r.object)
                                                        .toList();
                                              });
                                            },
                                          ),
                                          FlutterFlowIconButton(
                                            borderRadius: 20.0,
                                            buttonSize: 40.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            icon: const Icon(
                                              Icons.close,
                                              color: Color(0xFFF4F0F0),
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              _model.search = false;
                                              safeSetState(() {});
                                              await _model.listViewController2
                                                  ?.animateTo(
                                                _model.listViewController2!
                                                    .position.maxScrollExtent,
                                                duration:
                                                    const Duration(milliseconds: 100),
                                                curve: Curves.ease,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    if (_model.search == false)
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          StreamBuilder<ChatRecord>(
                                            stream: ChatRecord.getDocument(
                                                widget.chat!),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }

                                              final textChatRecord =
                                                  snapshot.data!;

                                              return Text(
                                                textChatRecord.chatName,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMediumFamily),
                                                        ),
                                              );
                                            },
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Builder(
                                                  builder: (context) =>
                                                      FlutterFlowIconButton(
                                                    borderRadius: 20.0,
                                                    buttonSize: 40.0,
                                                    icon: Icon(
                                                      Icons.more_vert,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 24.0,
                                                    ),
                                                    onPressed: () async {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
                                                          return Dialog(
                                                            elevation: 0,
                                                            insetPadding:
                                                                EdgeInsets.zero,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            alignment: const AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        dialogContext)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child:
                                                                  Dropdown1Widget(
                                                                chat: _model
                                                                    .readChatResults!,
                                                                messageList:
                                                                    _model
                                                                        .messages,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                FlutterFlowIconButton(
                                                  borderRadius: 8.0,
                                                  buttonSize: 40.0,
                                                  icon: Icon(
                                                    Icons.search,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  ),
                                                  onPressed: () async {
                                                    _model.search = true;
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ].divide(const SizedBox(width: 16.0)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  if (_model.search == false)
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 800.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 0.0),
                        child: StreamBuilder<List<MessageRecord>>(
                          stream: queryMessageRecord(
                            queryBuilder: (messageRecord) => messageRecord
                                .where(
                                  'chat',
                                  isEqualTo: widget.chat,
                                )
                                .orderBy('createdOn'),
                          )..listen((snapshot) {
                              List<MessageRecord> listViewMessageRecordList =
                                  snapshot;
                              if (_model.listViewPreviousSnapshot != null &&
                                  !const ListEquality(
                                          MessageRecordDocumentEquality())
                                      .equals(listViewMessageRecordList,
                                          _model.listViewPreviousSnapshot)) {
                                () async {
                                  await _model.listViewController1?.animateTo(
                                    _model.listViewController1!.position
                                        .maxScrollExtent,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.ease,
                                  );

                                  safeSetState(() {});
                                }();
                              }
                              _model.listViewPreviousSnapshot = snapshot;
                            }),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<MessageRecord> listViewMessageRecordList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewMessageRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewMessageRecord =
                                    listViewMessageRecordList[listViewIndex];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Align(
                                          alignment: AlignmentDirectional(
                                              valueOrDefault<double>(
                                                (listViewMessageRecord
                                                                    .type !=
                                                                '') &&
                                                        (listViewMessageRecord
                                                                .type ==
                                                            'user')
                                                    ? 1.0
                                                    : -1.0,
                                                0.0,
                                              ),
                                              0.0),
                                          child: Builder(
                                            builder: (context) => InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onLongPress: () async {
                                                await showDialog(
                                                  context: context,
                                                  builder: (dialogContext) {
                                                    return Dialog(
                                                      elevation: 0,
                                                      insetPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      alignment:
                                                          const AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(
                                                                  dialogContext)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: Dropdown2Widget(
                                                          message:
                                                              listViewMessageRecord,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.7,
                                                decoration: BoxDecoration(
                                                  color: valueOrDefault<Color>(
                                                    (listViewMessageRecord
                                                                        .type !=
                                                                    '') &&
                                                            (listViewMessageRecord
                                                                    .type ==
                                                                'user')
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                        valueOrDefault<double>(
                                                      (listViewMessageRecord
                                                                          .type !=
                                                                      '') &&
                                                              (listViewMessageRecord
                                                                      .type ==
                                                                  'user')
                                                          ? 20.0
                                                          : 0.0,
                                                      20.0,
                                                    )),
                                                    bottomRight:
                                                        Radius.circular(
                                                            valueOrDefault<
                                                                double>(
                                                      (listViewMessageRecord
                                                                          .type !=
                                                                      '') &&
                                                              (listViewMessageRecord
                                                                      .type ==
                                                                  'user')
                                                          ? 0.0
                                                          : 20.0,
                                                      0.0,
                                                    )),
                                                    topLeft:
                                                        const Radius.circular(20.0),
                                                    topRight:
                                                        const Radius.circular(20.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 16.0,
                                                          16.0, 16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height: 300.0,
                                                        child: custom_widgets
                                                            .MathStepSolutionDisplay(
                                                          width:
                                                              double.infinity,
                                                          height: 300.0,
                                                          modelOutput:
                                                              listViewMessageRecord
                                                                  .content,
                                                          type:
                                                              listViewMessageRecord
                                                                  .type,
                                                        ),
                                                      ),
                                                      Text(
                                                        functions
                                                            .convertTimestampToReadableDateTime(
                                                                listViewMessageRecord
                                                                    .createdOn),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily,
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    (listViewMessageRecord.type != '') &&
                                                                            (listViewMessageRecord.type ==
                                                                                'user')
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .secondaryText
                                                                        : Colors
                                                                            .white,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodySmallFamily),
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              controller: _model.listViewController1,
                            );
                          },
                        ),
                      ),
                    ),
                  if (_model.search == true)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          15.0, 15.0, 15.0, 15.0),
                      child: Container(
                        width: 400.0,
                        height: 800.0,
                        decoration: const BoxDecoration(),
                        child: Builder(
                          builder: (context) {
                            final results = _model.simpleSearchResults.toList();

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: results.length,
                              itemBuilder: (context, resultsIndex) {
                                final resultsItem = results[resultsIndex];
                                return Container(
                                  decoration: const BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        resultsItem.content.maybeHandleOverflow(
                                          maxChars: 50,
                                          replacement: '…',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                            ),
                                      ),
                                      Text(
                                        functions
                                            .convertTimestampToReadableDateTime(
                                                resultsItem.createdOn),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                            ),
                                      ),
                                      Divider(
                                        thickness: 2.0,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              controller: _model.listViewController2,
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              elevation: 2.0,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 109.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Builder(
                                  builder: (context) => Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: FlutterFlowIconButton(
                                      icon: const Icon(
                                        Icons.photo_camera,
                                      ),
                                      onPressed: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          allowPhoto: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          safeSetState(() =>
                                              _model.isDataUploading = true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          var downloadUrls = <String>[];
                                          try {
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.storagePath
                                                              .split('/')
                                                              .last,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
                                                        ))
                                                    .toList();

                                            downloadUrls = (await Future.wait(
                                              selectedMedia.map(
                                                (m) async => await uploadData(
                                                    m.storagePath, m.bytes),
                                              ),
                                            ))
                                                .where((u) => u != null)
                                                .map((u) => u!)
                                                .toList();
                                          } finally {
                                            _model.isDataUploading = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                                  selectedMedia.length &&
                                              downloadUrls.length ==
                                                  selectedMedia.length) {
                                            safeSetState(() {
                                              _model.uploadedLocalFile =
                                                  selectedUploadedFiles.first;
                                              _model.uploadedFileUrl =
                                                  downloadUrls.first;
                                            });
                                          } else {
                                            safeSetState(() {});
                                            return;
                                          }
                                        }

                                        if (_model.uploadedFileUrl != '') {
                                          await showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: const AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: CropImageWidget(
                                                    uploadUrl:
                                                        _model.uploadedFileUrl,
                                                    onCompleted:
                                                        (completedImageUrl) async {
                                                      Navigator.pop(context);
                                                      _model.ocr =
                                                          await AzureocrCall
                                                              .call(
                                                        url: completedImageUrl,
                                                      );

                                                      if ((_model
                                                              .ocr?.succeeded ??
                                                          true)) {
                                                        safeSetState(() {
                                                          _model.textController2
                                                                  ?.text =
                                                              functions.convertListToString(
                                                                  AzureocrCall
                                                                          .result(
                                                            (_model.ocr
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )!
                                                                      .toList());
                                                        });
                                                      } else {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title:
                                                                  const Text('Error'),
                                                              content: const Text(
                                                                  'OCR Error'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: const Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: const Text('Error'),
                                                content:
                                                    const Text('Upload File Failed'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: const Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }

                                        safeSetState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 20.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.textController2,
                                    focusNode: _model.textFieldFocusNode2,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Type your message...',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                          ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                        ),
                                    maxLines: null,
                                    minLines: 1,
                                    validator: _model.textController2Validator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ].divide(const SizedBox(width: 16.0)),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 25.0,
                            buttonSize: 50.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              if (_model.textController2.text != '') {
                                var messageRecordReference1 =
                                    MessageRecord.collection.doc();
                                await messageRecordReference1
                                    .set(createMessageRecordData(
                                  content: _model.textController2.text,
                                  status: 'Active',
                                  createdOn: getCurrentTimestamp.toString(),
                                  createdBy: currentUserReference,
                                  chat: widget.chat,
                                  type: 'user',
                                ));
                                _model.createUserMessage =
                                    MessageRecord.getDocumentFromData(
                                        createMessageRecordData(
                                          content: _model.textController2.text,
                                          status: 'Active',
                                          createdOn:
                                              getCurrentTimestamp.toString(),
                                          createdBy: currentUserReference,
                                          chat: widget.chat,
                                          type: 'user',
                                        ),
                                        messageRecordReference1);
                                _model.addToMessages(_model.createUserMessage!);
                                safeSetState(() {});
                                if (_model.createUserMessage != null) {
                                  _model.prompt = _model.textController2.text;
                                  _model.responding = true;
                                  safeSetState(() {});
                                  safeSetState(() {
                                    _model.textController2?.clear();
                                  });
                                  _model.responseResult =
                                      await MathProblemSolvingCall.call(
                                    messages:
                                        functions.formatPrompt(_model.prompt!),
                                    maxTokens: 200,
                                    topK: 48,
                                    topP: 0.8058213638777116,
                                    returnText: true,
                                    temp: 1.1604356324479213,
                                    doSample: true,
                                  );

                                  if ((_model.responseResult?.succeeded ??
                                      true)) {
                                    _model.refineOutput =
                                        await GeminiAPICall.call(
                                      text: 'Format and refine the step by step solutions of math question${functions.formatPrompt(_model.prompt!)}. Make sure no other question, just output this question solutions and answer only:${functions.postProcessOutput(MathProblemSolvingCall.response(
                                            (_model.responseResult?.jsonBody ??
                                                ''),
                                          )!, functions.formatPrompt(_model.textController2.text))}',
                                    );

                                    if ((_model.refineOutput?.succeeded ??
                                        true)) {
                                      var messageRecordReference2 =
                                          MessageRecord.collection.doc();
                                      await messageRecordReference2
                                          .set(createMessageRecordData(
                                        content: GeminiAPICall.output(
                                          (_model.refineOutput?.jsonBody ?? ''),
                                        ),
                                        status: 'Active',
                                        createdOn:
                                            getCurrentTimestamp.toString(),
                                        chat: widget.chat,
                                        type: 'system',
                                        createdBy: currentUserReference,
                                      ));
                                      _model.createFormatSuccessMessage =
                                          MessageRecord.getDocumentFromData(
                                              createMessageRecordData(
                                                content: GeminiAPICall.output(
                                                  (_model.refineOutput
                                                          ?.jsonBody ??
                                                      ''),
                                                ),
                                                status: 'Active',
                                                createdOn: getCurrentTimestamp
                                                    .toString(),
                                                chat: widget.chat,
                                                type: 'system',
                                                createdBy: currentUserReference,
                                              ),
                                              messageRecordReference2);
                                      _model.addToMessages(
                                          _model.createFormatSuccessMessage!);
                                      _model.prompt = null;
                                      _model.responding = false;
                                      safeSetState(() {});
                                    } else {
                                      var messageRecordReference3 =
                                          MessageRecord.collection.doc();
                                      await messageRecordReference3
                                          .set(createMessageRecordData(
                                        content:
                                            MathProblemSolvingCall.response(
                                          (_model.responseResult?.jsonBody ??
                                              ''),
                                        ),
                                        status: 'Active',
                                        createdOn:
                                            getCurrentTimestamp.toString(),
                                        chat: widget.chat,
                                        type: 'system',
                                        createdBy: currentUserReference,
                                      ));
                                      _model.createFormatFailMessage =
                                          MessageRecord.getDocumentFromData(
                                              createMessageRecordData(
                                                content: MathProblemSolvingCall
                                                    .response(
                                                  (_model.responseResult
                                                          ?.jsonBody ??
                                                      ''),
                                                ),
                                                status: 'Active',
                                                createdOn: getCurrentTimestamp
                                                    .toString(),
                                                chat: widget.chat,
                                                type: 'system',
                                                createdBy: currentUserReference,
                                              ),
                                              messageRecordReference3);
                                      _model.addToMessages(
                                          _model.createFormatFailMessage!);
                                      _model.prompt = null;
                                      _model.responding = false;
                                      safeSetState(() {});
                                    }
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: Text((_model.responseResult
                                                  ?.exceptionMessage ??
                                              '')),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text('Message Create Failed'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text('Meesage cannot be empty'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              safeSetState(() {
                                _model.textController2?.clear();
                              });

                              safeSetState(() {});
                            },
                          ),
                          if (_model.responding)
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: const SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child:
                                    custom_widgets.MyCircularProgressIndicator(
                                  width: 50.0,
                                  height: 50.0,
                                  size: 15.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ].divide(const SizedBox(width: 10.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
