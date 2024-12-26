import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _emailNotify = prefs.getBool('ff_emailNotify') ?? _emailNotify;
    });
    _safeInit(() {
      _pushNotify = prefs.getBool('ff_pushNotify') ?? _pushNotify;
    });
    _safeInit(() {
      _pushKey = prefs.getString('ff_pushKey') ?? _pushKey;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _scheme = '';
  String get scheme => _scheme;
  set scheme(String value) {
    _scheme = value;
  }

  bool _showGridLines = false;
  bool get showGridLines => _showGridLines;
  set showGridLines(bool value) {
    _showGridLines = value;
  }

  bool _showLegend = false;
  bool get showLegend => _showLegend;
  set showLegend(bool value) {
    _showLegend = value;
  }

  bool _showDataPoints = true;
  bool get showDataPoints => _showDataPoints;
  set showDataPoints(bool value) {
    _showDataPoints = value;
  }

  bool _explodeSlices = false;
  bool get explodeSlices => _explodeSlices;
  set explodeSlices(bool value) {
    _explodeSlices = value;
  }

  double _axisLabelFontSize = 16.0;
  double get axisLabelFontSize => _axisLabelFontSize;
  set axisLabelFontSize(double value) {
    _axisLabelFontSize = value;
  }

  double _titleFontSize = 20.0;
  double get titleFontSize => _titleFontSize;
  set titleFontSize(double value) {
    _titleFontSize = value;
  }

  double _legendFontSize = 14.0;
  double get legendFontSize => _legendFontSize;
  set legendFontSize(double value) {
    _legendFontSize = value;
  }

  double _dataPointSize = 6.0;
  double get dataPointSize => _dataPointSize;
  set dataPointSize(double value) {
    _dataPointSize = value;
  }

  double _lineThickness = 2.0;
  double get lineThickness => _lineThickness;
  set lineThickness(double value) {
    _lineThickness = value;
  }

  bool _showAxisLabels = false;
  bool get showAxisLabels => _showAxisLabels;
  set showAxisLabels(bool value) {
    _showAxisLabels = value;
  }

  bool _mode = false;
  bool get mode => _mode;
  set mode(bool value) {
    _mode = value;
  }

  double _chartHeight = 0.0;
  double get chartHeight => _chartHeight;
  set chartHeight(double value) {
    _chartHeight = value;
  }

  double _chartWidth = 0.0;
  double get chartWidth => _chartWidth;
  set chartWidth(double value) {
    _chartWidth = value;
  }

  String _chartTitle = 'Untitled Graph';
  String get chartTitle => _chartTitle;
  set chartTitle(String value) {
    _chartTitle = value;
  }

  String _chartType = '';
  String get chartType => _chartType;
  set chartType(String value) {
    _chartType = value;
  }

  String _xInput = '';
  String get xInput => _xInput;
  set xInput(String value) {
    _xInput = value;
  }

  String _yInput = '';
  String get yInput => _yInput;
  set yInput(String value) {
    _yInput = value;
  }

  String _currentInput = '';
  String get currentInput => _currentInput;
  set currentInput(String value) {
    _currentInput = value;
  }

  String _currentResult = '';
  String get currentResult => _currentResult;
  set currentResult(String value) {
    _currentResult = value;
  }

  String _alternativeResult = '';
  String get alternativeResult => _alternativeResult;
  set alternativeResult(String value) {
    _alternativeResult = value;
  }

  bool _emailNotify = false;
  bool get emailNotify => _emailNotify;
  set emailNotify(bool value) {
    _emailNotify = value;
    prefs.setBool('ff_emailNotify', value);
  }

  bool _pushNotify = false;
  bool get pushNotify => _pushNotify;
  set pushNotify(bool value) {
    _pushNotify = value;
    prefs.setBool('ff_pushNotify', value);
  }

  String _pushKey = '';
  String get pushKey => _pushKey;
  set pushKey(String value) {
    _pushKey = value;
    prefs.setString('ff_pushKey', value);
  }

  String _searchKeyword = '';
  String get searchKeyword => _searchKeyword;
  set searchKeyword(String value) {
    _searchKeyword = value;
  }

  String _chatGroup = '';
  String get chatGroup => _chatGroup;
  set chatGroup(String value) {
    _chatGroup = value;
  }

  DocumentReference? _chatList;
  DocumentReference? get chatList => _chatList;
  set chatList(DocumentReference? value) {
    _chatList = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
