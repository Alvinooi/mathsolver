import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class MathProblemSolvingCall {
  static Future<ApiCallResponse> call({
    String? messages = 'Solve 1+1.',
    int? maxTokens = 200,
    int? topK = 48,
    double? topP = 0.8058213638777116,
    bool? returnText = true,
    double? temp = 1.1604356324479213,
    bool? doSample = true,
  }) async {
    final ffApiRequestBody = '''
{
  "inputs": "$messages",
  "parameters": {
    "top_k": $topK,
    "top_p": $topP,
    "temperature": $temp,
    "max_new_tokens": $maxTokens,
    "return_text": $returnText,
    "do_sample": $doSample
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'MathProblemSolving',
      apiUrl:
          'https://njb6549ggiuowgb1.us-east-1.aws.endpoints.huggingface.cloud',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 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',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? response(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].generated_text''',
      ));
}

class OptiicCall {
  static Future<ApiCallResponse> call({
    String? apiKey = 'DiqfeLonzvBJ5cu5Ga77jcap6HHQigAM79tdrB43uFbJ',
    String? url =
        'https://www.mycism.com/wp-content/uploads/2020/10/figure-out-math-information-cism.jpeg',
  }) async {
    final ffApiRequestBody = '''
{
  "apiKey": "$apiKey",
  "url": "$url"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OPTIIC',
      apiUrl: 'https://api.optiic.dev/process',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AzureocrCall {
  static Future<ApiCallResponse> call({
    String? url =
        'https://learn.microsoft.com/azure/ai-services/computer-vision/media/quickstarts/presentation.png',
  }) async {
    final ffApiRequestBody = '''
{
  "url": "$url"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AZUREOCR',
      apiUrl:
          'https://yxooiocr2.cognitiveservices.azure.com/computervision/imageanalysis:analyze?features=caption,read&model-version=latest&language=en&api-version=2024-02-01',
      callType: ApiCallType.POST,
      headers: {
        'Ocp-Apim-Subscription-Key':
            '3lmh18fbBlr86MXLjk8n22MGkUCjJ9eNGuH7ZZqXdM1EwzZ5wPgAJQQJ99AJACYeBjFXJ3w3AAAFACOGQsdm',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? description(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.captionResult.text''',
      ));
  static List<String>? result(dynamic response) => (getJsonField(
        response,
        r'''$.readResult.blocks[:].lines[:].text''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GeminiAPICall {
  static Future<ApiCallResponse> call({
    String? text = '',
  }) async {
    final ffApiRequestBody = '''
{
  "contents": [
    {
      "parts": [
        {
          "text": "${escapeStringForJson(text)}"
        }
      ]
    }
  ]
}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'GeminiAPI',
      apiUrl:
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyAnuusThOVrd6qFhH0X1-il0ZUAZKS_W5E',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? output(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.candidates[:].content.parts[:].text''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
