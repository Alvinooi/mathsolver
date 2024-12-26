import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chat_widget.dart' show ChatWidget;
import 'package:flutter/material.dart';

class ChatModel extends FlutterFlowModel<ChatWidget> {
  ///  Local state fields for this page.

  List<MessageRecord> messages = [];
  void addToMessages(MessageRecord item) => messages.add(item);
  void removeFromMessages(MessageRecord item) => messages.remove(item);
  void removeAtIndexFromMessages(int index) => messages.removeAt(index);
  void insertAtIndexInMessages(int index, MessageRecord item) =>
      messages.insert(index, item);
  void updateMessagesAtIndex(int index, Function(MessageRecord) updateFn) =>
      messages[index] = updateFn(messages[index]);

  bool search = true;

  String? prompt;

  bool responding = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (AZUREOCR)] action in Chat widget.
  ApiCallResponse? apiResults75;
  // Stores action output result for [Backend Call - Read Document] action in Chat widget.
  ChatRecord? readChatResults;
  // Stores action output result for [Firestore Query - Query a collection] action in Chat widget.
  List<MessageRecord>? readChatMessages;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  List<MessageRecord> simpleSearchResults = [];
  // State field(s) for ListView widget.
  ScrollController? listViewController1;
  List<MessageRecord>? listViewPreviousSnapshot;
  // State field(s) for ListView widget.
  ScrollController? listViewController2;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - API (AZUREOCR)] action in IconButton widget.
  ApiCallResponse? ocr;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  MessageRecord? createUserMessage;
  // Stores action output result for [Backend Call - API (MathProblemSolving)] action in IconButton widget.
  ApiCallResponse? responseResult;
  // Stores action output result for [Backend Call - API (GeminiAPI)] action in IconButton widget.
  ApiCallResponse? refineOutput;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  MessageRecord? createFormatSuccessMessage;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  MessageRecord? createFormatFailMessage;

  @override
  void initState(BuildContext context) {
    listViewController1 = ScrollController();
    listViewController2 = ScrollController();
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    listViewController1?.dispose();
    listViewController2?.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
