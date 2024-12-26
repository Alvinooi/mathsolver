import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GraphRecord extends FirestoreRecord {
  GraphRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "graphTitle" field.
  String? _graphTitle;
  String get graphTitle => _graphTitle ?? '';
  bool hasGraphTitle() => _graphTitle != null;

  // "colorScheme" field.
  String? _colorScheme;
  String get colorScheme => _colorScheme ?? '';
  bool hasColorScheme() => _colorScheme != null;

  // "showLegend" field.
  bool? _showLegend;
  bool get showLegend => _showLegend ?? false;
  bool hasShowLegend() => _showLegend != null;

  // "showDataPoints" field.
  bool? _showDataPoints;
  bool get showDataPoints => _showDataPoints ?? false;
  bool hasShowDataPoints() => _showDataPoints != null;

  // "showAxisLabels" field.
  bool? _showAxisLabels;
  bool get showAxisLabels => _showAxisLabels ?? false;
  bool hasShowAxisLabels() => _showAxisLabels != null;

  // "lineThickness" field.
  double? _lineThickness;
  double get lineThickness => _lineThickness ?? 0.0;
  bool hasLineThickness() => _lineThickness != null;

  // "dataPointSize" field.
  double? _dataPointSize;
  double get dataPointSize => _dataPointSize ?? 0.0;
  bool hasDataPointSize() => _dataPointSize != null;

  // "explodeSlices" field.
  bool? _explodeSlices;
  bool get explodeSlices => _explodeSlices ?? false;
  bool hasExplodeSlices() => _explodeSlices != null;

  // "titleFontSize" field.
  double? _titleFontSize;
  double get titleFontSize => _titleFontSize ?? 0.0;
  bool hasTitleFontSize() => _titleFontSize != null;

  // "axisLabelsFontSize" field.
  double? _axisLabelsFontSize;
  double get axisLabelsFontSize => _axisLabelsFontSize ?? 0.0;
  bool hasAxisLabelsFontSize() => _axisLabelsFontSize != null;

  // "legendFontSize" field.
  double? _legendFontSize;
  double get legendFontSize => _legendFontSize ?? 0.0;
  bool hasLegendFontSize() => _legendFontSize != null;

  // "showGridLines" field.
  bool? _showGridLines;
  bool get showGridLines => _showGridLines ?? false;
  bool hasShowGridLines() => _showGridLines != null;

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "createdOn" field.
  DateTime? _createdOn;
  DateTime? get createdOn => _createdOn;
  bool hasCreatedOn() => _createdOn != null;

  // "updatedOn" field.
  DateTime? _updatedOn;
  DateTime? get updatedOn => _updatedOn;
  bool hasUpdatedOn() => _updatedOn != null;

  // "xInput" field.
  String? _xInput;
  String get xInput => _xInput ?? '';
  bool hasXInput() => _xInput != null;

  // "yInput" field.
  String? _yInput;
  String get yInput => _yInput ?? '';
  bool hasYInput() => _yInput != null;

  // "graphType" field.
  String? _graphType;
  String get graphType => _graphType ?? '';
  bool hasGraphType() => _graphType != null;

  void _initializeFields() {
    _graphTitle = snapshotData['graphTitle'] as String?;
    _colorScheme = snapshotData['colorScheme'] as String?;
    _showLegend = snapshotData['showLegend'] as bool?;
    _showDataPoints = snapshotData['showDataPoints'] as bool?;
    _showAxisLabels = snapshotData['showAxisLabels'] as bool?;
    _lineThickness = castToType<double>(snapshotData['lineThickness']);
    _dataPointSize = castToType<double>(snapshotData['dataPointSize']);
    _explodeSlices = snapshotData['explodeSlices'] as bool?;
    _titleFontSize = castToType<double>(snapshotData['titleFontSize']);
    _axisLabelsFontSize =
        castToType<double>(snapshotData['axisLabelsFontSize']);
    _legendFontSize = castToType<double>(snapshotData['legendFontSize']);
    _showGridLines = snapshotData['showGridLines'] as bool?;
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _createdOn = snapshotData['createdOn'] as DateTime?;
    _updatedOn = snapshotData['updatedOn'] as DateTime?;
    _xInput = snapshotData['xInput'] as String?;
    _yInput = snapshotData['yInput'] as String?;
    _graphType = snapshotData['graphType'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('graph');

  static Stream<GraphRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GraphRecord.fromSnapshot(s));

  static Future<GraphRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GraphRecord.fromSnapshot(s));

  static GraphRecord fromSnapshot(DocumentSnapshot snapshot) => GraphRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GraphRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GraphRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GraphRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GraphRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGraphRecordData({
  String? graphTitle,
  String? colorScheme,
  bool? showLegend,
  bool? showDataPoints,
  bool? showAxisLabels,
  double? lineThickness,
  double? dataPointSize,
  bool? explodeSlices,
  double? titleFontSize,
  double? axisLabelsFontSize,
  double? legendFontSize,
  bool? showGridLines,
  DocumentReference? createdBy,
  DateTime? createdOn,
  DateTime? updatedOn,
  String? xInput,
  String? yInput,
  String? graphType,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'graphTitle': graphTitle,
      'colorScheme': colorScheme,
      'showLegend': showLegend,
      'showDataPoints': showDataPoints,
      'showAxisLabels': showAxisLabels,
      'lineThickness': lineThickness,
      'dataPointSize': dataPointSize,
      'explodeSlices': explodeSlices,
      'titleFontSize': titleFontSize,
      'axisLabelsFontSize': axisLabelsFontSize,
      'legendFontSize': legendFontSize,
      'showGridLines': showGridLines,
      'createdBy': createdBy,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'xInput': xInput,
      'yInput': yInput,
      'graphType': graphType,
    }.withoutNulls,
  );

  return firestoreData;
}

class GraphRecordDocumentEquality implements Equality<GraphRecord> {
  const GraphRecordDocumentEquality();

  @override
  bool equals(GraphRecord? e1, GraphRecord? e2) {
    return e1?.graphTitle == e2?.graphTitle &&
        e1?.colorScheme == e2?.colorScheme &&
        e1?.showLegend == e2?.showLegend &&
        e1?.showDataPoints == e2?.showDataPoints &&
        e1?.showAxisLabels == e2?.showAxisLabels &&
        e1?.lineThickness == e2?.lineThickness &&
        e1?.dataPointSize == e2?.dataPointSize &&
        e1?.explodeSlices == e2?.explodeSlices &&
        e1?.titleFontSize == e2?.titleFontSize &&
        e1?.axisLabelsFontSize == e2?.axisLabelsFontSize &&
        e1?.legendFontSize == e2?.legendFontSize &&
        e1?.showGridLines == e2?.showGridLines &&
        e1?.createdBy == e2?.createdBy &&
        e1?.createdOn == e2?.createdOn &&
        e1?.updatedOn == e2?.updatedOn &&
        e1?.xInput == e2?.xInput &&
        e1?.yInput == e2?.yInput &&
        e1?.graphType == e2?.graphType;
  }

  @override
  int hash(GraphRecord? e) => const ListEquality().hash([
        e?.graphTitle,
        e?.colorScheme,
        e?.showLegend,
        e?.showDataPoints,
        e?.showAxisLabels,
        e?.lineThickness,
        e?.dataPointSize,
        e?.explodeSlices,
        e?.titleFontSize,
        e?.axisLabelsFontSize,
        e?.legendFontSize,
        e?.showGridLines,
        e?.createdBy,
        e?.createdOn,
        e?.updatedOn,
        e?.xInput,
        e?.yInput,
        e?.graphType
      ]);

  @override
  bool isValidKey(Object? o) => o is GraphRecord;
}
