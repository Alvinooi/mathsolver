import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalculationRecord extends FirestoreRecord {
  CalculationRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "result" field.
  String? _result;
  String get result => _result ?? '';
  bool hasResult() => _result != null;

  // "alternate" field.
  String? _alternate;
  String get alternate => _alternate ?? '';
  bool hasAlternate() => _alternate != null;

  // "createdOn" field.
  DateTime? _createdOn;
  DateTime? get createdOn => _createdOn;
  bool hasCreatedOn() => _createdOn != null;

  // "updatedOn" field.
  DateTime? _updatedOn;
  DateTime? get updatedOn => _updatedOn;
  bool hasUpdatedOn() => _updatedOn != null;

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "expression" field.
  String? _expression;
  String get expression => _expression ?? '';
  bool hasExpression() => _expression != null;

  void _initializeFields() {
    _result = snapshotData['result'] as String?;
    _alternate = snapshotData['alternate'] as String?;
    _createdOn = snapshotData['createdOn'] as DateTime?;
    _updatedOn = snapshotData['updatedOn'] as DateTime?;
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _expression = snapshotData['expression'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('calculation');

  static Stream<CalculationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CalculationRecord.fromSnapshot(s));

  static Future<CalculationRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CalculationRecord.fromSnapshot(s));

  static CalculationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CalculationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CalculationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CalculationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CalculationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CalculationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCalculationRecordData({
  String? result,
  String? alternate,
  DateTime? createdOn,
  DateTime? updatedOn,
  DocumentReference? createdBy,
  String? expression,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'result': result,
      'alternate': alternate,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'createdBy': createdBy,
      'expression': expression,
    }.withoutNulls,
  );

  return firestoreData;
}

class CalculationRecordDocumentEquality implements Equality<CalculationRecord> {
  const CalculationRecordDocumentEquality();

  @override
  bool equals(CalculationRecord? e1, CalculationRecord? e2) {
    return e1?.result == e2?.result &&
        e1?.alternate == e2?.alternate &&
        e1?.createdOn == e2?.createdOn &&
        e1?.updatedOn == e2?.updatedOn &&
        e1?.createdBy == e2?.createdBy &&
        e1?.expression == e2?.expression;
  }

  @override
  int hash(CalculationRecord? e) => const ListEquality().hash([
        e?.result,
        e?.alternate,
        e?.createdOn,
        e?.updatedOn,
        e?.createdBy,
        e?.expression
      ]);

  @override
  bool isValidKey(Object? o) => o is CalculationRecord;
}
