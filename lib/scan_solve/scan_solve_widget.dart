import '/backend/api_requests/api_calls.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/create_chat_widget.dart';
import '/components/crop_image_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'scan_solve_model.dart';
export 'scan_solve_model.dart';

class ScanSolveWidget extends StatefulWidget {
  const ScanSolveWidget({super.key});

  @override
  State<ScanSolveWidget> createState() => _ScanSolveWidgetState();
}

class _ScanSolveWidgetState extends State<ScanSolveWidget> {
  late ScanSolveModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScanSolveModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.readOnly = true;
      _model.responding = false;
      _model.imageLoad = false;
      safeSetState(() {});
      final selectedMedia = await selectMediaWithSourceBottomSheet(
        context: context,
        allowPhoto: true,
      );
      if (selectedMedia != null &&
          selectedMedia
              .every((m) => validateFileFormat(m.storagePath, context))) {
        safeSetState(() => _model.isDataUploading1 = true);
        var selectedUploadedFiles = <FFUploadedFile>[];

        var downloadUrls = <String>[];
        try {
          selectedUploadedFiles = selectedMedia
              .map((m) => FFUploadedFile(
                    name: m.storagePath.split('/').last,
                    bytes: m.bytes,
                    height: m.dimensions?.height,
                    width: m.dimensions?.width,
                    blurHash: m.blurHash,
                  ))
              .toList();

          downloadUrls = (await Future.wait(
            selectedMedia.map(
              (m) async => await uploadData(m.storagePath, m.bytes),
            ),
          ))
              .where((u) => u != null)
              .map((u) => u!)
              .toList();
        } finally {
          _model.isDataUploading1 = false;
        }
        if (selectedUploadedFiles.length == selectedMedia.length &&
            downloadUrls.length == selectedMedia.length) {
          safeSetState(() {
            _model.uploadedLocalFile1 = selectedUploadedFiles.first;
            _model.uploadedFileUrl1 = downloadUrls.first;
          });
        } else {
          safeSetState(() {});
          return;
        }
      }

      if (_model.uploadedFileUrl1 != '') {
        await showDialog(
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: const AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(dialogContext).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: CropImageWidget(
                  uploadUrl: _model.uploadedFileUrl1,
                  onCompleted: (completedImageUrl) async {
                    Navigator.pop(context);
                    _model.imageLoad = true;
                    safeSetState(() {});
                    _model.apiResult8p1 = await AzureocrCall.call(
                      url: completedImageUrl,
                    );

                    if ((_model.apiResult8p1?.succeeded ?? true)) {
                      _model.convertStringPath =
                          await actions.convertStringtoPath(
                        completedImageUrl,
                      );
                      _model.prompt =
                          functions.convertListToString(AzureocrCall.result(
                        (_model.apiResult8p1?.jsonBody ?? ''),
                      )!
                              .toList());
                      _model.imageUrl = _model.convertStringPath;
                      _model.imageLoad = false;
                      safeSetState(() {});
                      safeSetState(() {
                        _model.textController?.text =
                            functions.convertListToString(AzureocrCall.result(
                          (_model.apiResult8p1?.jsonBody ?? ''),
                        )!
                                .toList());
                      });
                    } else {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('OCR Error'),
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
              content: const Text('No image uploaded.'),
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
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.arrow_back,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            context.safePop();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 20.0, 0.0, 20.0),
                          child: Text(
                            'Scan & Solve',
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
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      if (_model.imageUrl != null && _model.imageUrl != '')
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            _model.imageUrl!,
                            width: double.infinity,
                            height: 500.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      if (_model.imageUrl == null || _model.imageUrl == '')
                        Container(
                          width: double.infinity,
                          height: 500.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Stack(
                            children: [
                              if ((_model.imageUrl == null ||
                                      _model.imageUrl == '') &&
                                  !_model.imageLoad)
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    'No Image Selected',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .displaySmallFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmallFamily),
                                        ),
                                  ),
                                ),
                              if ((_model.imageUrl == null ||
                                      _model.imageUrl == '') &&
                                  _model.imageLoad)
                                const SizedBox(
                                  width: double.infinity,
                                  height: 500.0,
                                  child: custom_widgets
                                      .MyCircularProgressIndicator(
                                    width: double.infinity,
                                    height: 500.0,
                                    size: 20.0,
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prompt',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleMediumFamily),
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: 230.0,
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                autofocus: false,
                                readOnly: _model.readOnly,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: FlutterFlowTheme.of(context)
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
                                  hintText: 'Prompt',
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
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
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
                            Builder(
                              builder: (context) => FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.upload_sharp,
                                  color:
                                      FlutterFlowTheme.of(context).customColor1,
                                  size: 24.0,
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
                                    safeSetState(
                                        () => _model.isDataUploading2 = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    var downloadUrls = <String>[];
                                    try {
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
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
                                      _model.isDataUploading2 = false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                            selectedMedia.length &&
                                        downloadUrls.length ==
                                            selectedMedia.length) {
                                      safeSetState(() {
                                        _model.uploadedLocalFile2 =
                                            selectedUploadedFiles.first;
                                        _model.uploadedFileUrl2 =
                                            downloadUrls.first;
                                      });
                                    } else {
                                      safeSetState(() {});
                                      return;
                                    }
                                  }

                                  if (_model.uploadedFileUrl1 != '') {
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
                                            child: CropImageWidget(
                                              uploadUrl:
                                                  _model.uploadedFileUrl1,
                                              onCompleted:
                                                  (completedImageUrl) async {
                                                Navigator.pop(context);
                                                _model.imageLoad = true;
                                                safeSetState(() {});
                                                _model.apiResult8p2 =
                                                    await AzureocrCall.call(
                                                  url: completedImageUrl,
                                                );

                                                if ((_model.apiResult8p2
                                                        ?.succeeded ??
                                                    true)) {
                                                  _model.convertStringPath2 =
                                                      await actions
                                                          .convertStringtoPath(
                                                    completedImageUrl,
                                                  );
                                                  _model.prompt = functions
                                                      .convertListToString(
                                                          AzureocrCall.result(
                                                    (_model.apiResult8p1
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!
                                                              .toList());
                                                  _model.imageUrl =
                                                      _model.convertStringPath2;
                                                  _model.imageLoad = false;
                                                  safeSetState(() {});
                                                  safeSetState(() {
                                                    _model.textController
                                                            ?.text =
                                                        functions
                                                            .convertListToString(
                                                                AzureocrCall
                                                                        .result(
                                                      (_model.apiResult8p1
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
                                                        title: const Text('Error'),
                                                        content:
                                                            const Text('OCR Error'),
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
                                          content: const Text('Upload File Failed'),
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

                                  safeSetState(() {});
                                },
                              ),
                            ),
                            Stack(
                              children: [
                                if (!_model.readOnly)
                                  FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).primary,
                                    icon: Icon(
                                      Icons.save,
                                      color: FlutterFlowTheme.of(context)
                                          .customColor1,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      _model.readOnly = true;
                                      _model.prompt =
                                          _model.textController.text;
                                      safeSetState(() {});
                                      _model.responding = true;
                                      safeSetState(() {});
                                      _model.responseResult =
                                          await MathProblemSolvingCall.call(
                                        messages: functions.formatPrompt(
                                            _model.textController.text),
                                        maxTokens: 126,
                                        topK: 22,
                                        topP: 0.932273085730471,
                                        returnText: true,
                                        temp: 0.9965680566916504,
                                        doSample: false,
                                      );

                                      if ((_model.responseResult?.succeeded ??
                                          true)) {
                                        _model.refineOutput =
                                            await GeminiAPICall.call(
                                          text:
                                              'Format and refine the step by step solutions of math question${functions.formatPrompt(MathProblemSolvingCall.response(
                                            (_model.responseResult?.jsonBody ??
                                                ''),
                                          )!)}. Make sure no other question, just output this question solutions and answer only:${functions.postProcessOutput(_model.response, functions.formatPrompt(_model.prompt))}',
                                        );

                                        if ((_model.refineOutput?.succeeded ??
                                            true)) {
                                          _model.response =
                                              GeminiAPICall.output(
                                            (_model.refineOutput?.jsonBody ??
                                                ''),
                                          )!;
                                          _model.responding = false;
                                          safeSetState(() {});
                                        } else {
                                          _model.responding = false;
                                          safeSetState(() {});
                                        }
                                      } else {
                                        _model.responding = true;
                                        safeSetState(() {});
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text('Error'),
                                              content: Text((_model
                                                      .responseResult
                                                      ?.exceptionMessage ??
                                                  '')),
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
                                if (_model.readOnly)
                                  FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).primary,
                                    icon: Icon(
                                      Icons.edit,
                                      color: FlutterFlowTheme.of(context)
                                          .customColor1,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      _model.readOnly = false;
                                      safeSetState(() {});
                                    },
                                  ),
                              ],
                            ),
                          ].divide(const SizedBox(width: 8.0)),
                        ),
                      ].divide(const SizedBox(height: 10.0)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Response',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleMediumFamily),
                              ),
                        ),
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 300.0,
                                child: custom_widgets.MathStepSolutionDisplay(
                                  width: double.infinity,
                                  height: 300.0,
                                  modelOutput: _model.response,
                                  type: 'user',
                                ),
                              ),
                            ),
                            if (_model.responding)
                              const SizedBox(
                                width: double.infinity,
                                height: 300.0,
                                child:
                                    custom_widgets.MyCircularProgressIndicator(
                                  width: double.infinity,
                                  height: 300.0,
                                  size: 20.0,
                                ),
                              ),
                          ],
                        ),
                      ].divide(const SizedBox(height: 10.0)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                context.safePop();
                              },
                              text: 'Cancel',
                              options: FFButtonOptions(
                                width: 150.0,
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                            Builder(
                              builder: (context) => FFButtonWidget(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: CreateChatWidget(
                                            quickAccess: true,
                                            prompt: _model.prompt,
                                            response: _model.response,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                text: 'Start New Chat',
                                options: FFButtonOptions(
                                  width: 180.0,
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
                            ),
                          ],
                        ),
                      ].divide(const SizedBox(height: 10.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
