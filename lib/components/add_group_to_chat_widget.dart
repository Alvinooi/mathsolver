import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_group_to_chat_model.dart';
export 'add_group_to_chat_model.dart';

class AddGroupToChatWidget extends StatefulWidget {
  const AddGroupToChatWidget({
    super.key,
    this.group,
  });

  final DocumentReference? group;

  @override
  State<AddGroupToChatWidget> createState() => _AddGroupToChatWidgetState();
}

class _AddGroupToChatWidgetState extends State<AddGroupToChatWidget> {
  late AddGroupToChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddGroupToChatModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chat',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineMediumFamily,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context)
                                  .headlineMediumFamily),
                        ),
                  ),
                  FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.clear,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<List<ChatRecord>>(
                      stream: queryChatRecord(
                        queryBuilder: (chatRecord) => chatRecord
                            .where(
                              'members',
                              arrayContains: currentUserReference,
                            )
                            .where(
                              'groupID',
                              isEqualTo: null,
                            )
                            .orderBy('chatName'),
                      ),
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
                        List<ChatRecord> columnChatRecordList = snapshot.data!;

                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(columnChatRecordList.length,
                                (columnIndex) {
                              final columnChatRecord =
                                  columnChatRecordList[columnIndex];
                              return Visibility(
                                visible: (columnChatRecord.groupID == null) ||
                                    (columnChatRecord.groupID == widget.group),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Theme(
                                    data: ThemeData(
                                      checkboxTheme: const CheckboxThemeData(
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      unselectedWidgetColor:
                                          FlutterFlowTheme.of(context).accent4,
                                    ),
                                    child: CheckboxListTile(
                                      value: _model.checkboxListTileValueMap[
                                              columnChatRecord] ??=
                                          columnChatRecord.groupID ==
                                              widget.group,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.checkboxListTileValueMap[
                                                columnChatRecord] = newValue!);
                                        if (newValue!) {
                                          await columnChatRecord.reference
                                              .update(createChatRecordData(
                                            groupID: widget.group,
                                          ));
                                          _model.updateUserChat1 =
                                              await queryChatRecordOnce(
                                            queryBuilder: (chatRecord) =>
                                                chatRecord
                                                    .where(
                                                      'createdBy',
                                                      isEqualTo:
                                                          currentUserReference,
                                                    )
                                                    .where(
                                                      'groupID',
                                                      isEqualTo: null,
                                                    )
                                                    .where(
                                                      'groupID',
                                                      isEqualTo: widget.group,
                                                    )
                                                    .orderBy('chatName'),
                                          );
                                          _model.addChatList = _model
                                              .updateUserChat1!
                                              .toList()
                                              .cast<ChatRecord>();
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        } else {
                                          await columnChatRecord.reference
                                              .update(createChatRecordData(
                                            groupID: null,
                                          ));
                                          _model.updateUserChat2 =
                                              await queryChatRecordOnce(
                                            queryBuilder: (chatRecord) =>
                                                chatRecord
                                                    .where(
                                                      'createdBy',
                                                      isEqualTo:
                                                          currentUserReference,
                                                    )
                                                    .where(
                                                      'groupID',
                                                      isEqualTo: null,
                                                    )
                                                    .where(
                                                      'groupID',
                                                      isEqualTo: widget.group,
                                                    )
                                                    .orderBy('chatName'),
                                          );
                                          _model.addChatList = _model
                                              .updateUserChat2!
                                              .toList()
                                              .cast<ChatRecord>();
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        }
                                      },
                                      title: Text(
                                        columnChatRecord.chatName,
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMediumFamily,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMediumFamily),
                                            ),
                                      ),
                                      tileColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      checkColor:
                                          FlutterFlowTheme.of(context).info,
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12.0, 0.0, 12.0, 0.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),
              ),
            ].divide(const SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
