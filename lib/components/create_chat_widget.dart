import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_chat_model.dart';
export 'create_chat_model.dart';

class CreateChatWidget extends StatefulWidget {
  /// create chat dialog which allow user to input chat name and confirm
  /// creation
  const CreateChatWidget({
    super.key,
    required this.quickAccess,
    this.prompt,
    this.response,
  });

  final bool? quickAccess;
  final String? prompt;
  final String? response;

  @override
  State<CreateChatWidget> createState() => _CreateChatWidgetState();
}

class _CreateChatWidgetState extends State<CreateChatWidget> {
  late CreateChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateChatModel());

    _model.chatNameTextController ??= TextEditingController();
    _model.chatNameFocusNode ??= FocusNode();

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
        width: MediaQuery.sizeOf(context).width * 1.337,
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
              Text(
                'Create New Chat',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).headlineMediumFamily),
                    ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chat Name',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                  ),
                  TextFormField(
                    controller: _model.chatNameTextController,
                    focusNode: _model.chatNameFocusNode,
                    autofocus: false,
                    textInputAction: TextInputAction.next,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintStyle: FlutterFlowTheme.of(context)
                          .bodyLarge
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyLargeFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyLargeFamily),
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryBackground,
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
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                    minLines: 1,
                    validator: _model.chatNameTextControllerValidator
                        .asValidator(context),
                  ),
                ].divide(const SizedBox(height: 8.0)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                    options: FFButtonOptions(
                      width: 100.0,
                      height: 40.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      var chatRecordReference = ChatRecord.collection.doc();
                      await chatRecordReference.set({
                        ...createChatRecordData(
                          chatName: _model.chatNameTextController.text,
                          status: 'Active',
                          createdOn: getCurrentTimestamp,
                          createdBy: currentUserReference,
                        ),
                        ...mapToFirestore(
                          {
                            'members': [currentUserReference],
                            'updatedOn': FieldValue.serverTimestamp(),
                          },
                        ),
                      });
                      _model.createChatResult = ChatRecord.getDocumentFromData({
                        ...createChatRecordData(
                          chatName: _model.chatNameTextController.text,
                          status: 'Active',
                          createdOn: getCurrentTimestamp,
                          createdBy: currentUserReference,
                        ),
                        ...mapToFirestore(
                          {
                            'members': [currentUserReference],
                            'updatedOn': DateTime.now(),
                          },
                        ),
                      }, chatRecordReference);
                      if (_model.createChatResult != null) {
                        if (widget.quickAccess!) {
                          var messageRecordReference1 =
                              MessageRecord.collection.doc();
                          await messageRecordReference1
                              .set(createMessageRecordData(
                            content: widget.prompt,
                            status: 'Active',
                            createdOn: getCurrentTimestamp.toString(),
                            createdBy: currentUserReference,
                            chat: _model.createChatResult?.reference,
                            type: 'user',
                          ));
                          _model.createNewPrompt =
                              MessageRecord.getDocumentFromData(
                                  createMessageRecordData(
                                    content: widget.prompt,
                                    status: 'Active',
                                    createdOn: getCurrentTimestamp.toString(),
                                    createdBy: currentUserReference,
                                    chat: _model.createChatResult?.reference,
                                    type: 'user',
                                  ),
                                  messageRecordReference1);

                          var messageRecordReference2 =
                              MessageRecord.collection.doc();
                          await messageRecordReference2
                              .set(createMessageRecordData(
                            content: widget.response,
                            status: 'Active',
                            createdOn: getCurrentTimestamp.toString(),
                            createdBy: currentUserReference,
                            chat: _model.createChatResult?.reference,
                            type: 'system',
                          ));
                          _model.createNewResponse =
                              MessageRecord.getDocumentFromData(
                                  createMessageRecordData(
                                    content: widget.response,
                                    status: 'Active',
                                    createdOn: getCurrentTimestamp.toString(),
                                    createdBy: currentUserReference,
                                    chat: _model.createChatResult?.reference,
                                    type: 'system',
                                  ),
                                  messageRecordReference2);
                        }

                        context.pushNamed(
                          'Chat',
                          queryParameters: {
                            'chat': serializeParam(
                              _model.createChatResult?.reference,
                              ParamType.DocumentReference,
                            ),
                            'home': serializeParam(
                              false,
                              ParamType.bool,
                            ),
                          }.withoutNulls,
                        );
                      }

                      safeSetState(() {});
                    },
                    text: 'Create',
                    options: FFButtonOptions(
                      width: 100.0,
                      height: 40.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: Colors.white,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                      elevation: 0.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ].divide(const SizedBox(width: 16.0)),
              ),
            ].divide(const SizedBox(height: 24.0)),
          ),
        ),
      ),
    );
  }
}
