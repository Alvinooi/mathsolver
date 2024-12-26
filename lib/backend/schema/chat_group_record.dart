import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatGroupRecord extends FirestoreRecord {
  ChatGroupRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "createdOn" field.
  DateTime? _createdOn;
  DateTime? get createdOn => _createdOn;
  bool hasCreatedOn() => _createdOn != null;

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "groupName" field.
  String? _groupName;
  String get groupName => _groupName ?? '';
  bool hasGroupName() => _groupName != null;

  // "labelColour" field.
  Color? _labelColour;
  Color? get labelColour => _labelColour;
  bool hasLabelColour() => _labelColour != null;

  void _initializeFields() {
    _createdOn = snapshotData['createdOn'] as DateTime?;
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _groupName = snapshotData['groupName'] as String?;
    _labelColour = getSchemaColor(snapshotData['labelColour']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chatGroup');

  static Stream<ChatGroupRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatGroupRecord.fromSnapshot(s));

  static Future<ChatGroupRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatGroupRecord.fromSnapshot(s));

  static ChatGroupRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatGroupRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatGroupRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatGroupRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatGroupRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatGroupRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatGroupRecordData({
  DateTime? createdOn,
  DocumentReference? createdBy,
  String? groupName,
  Color? labelColour,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'createdOn': createdOn,
      'createdBy': createdBy,
      'groupName': groupName,
      'labelColour': labelColour,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatGroupRecordDocumentEquality implements Equality<ChatGroupRecord> {
  const ChatGroupRecordDocumentEquality();

  @override
  bool equals(ChatGroupRecord? e1, ChatGroupRecord? e2) {
    return e1?.createdOn == e2?.createdOn &&
        e1?.createdBy == e2?.createdBy &&
        e1?.groupName == e2?.groupName &&
        e1?.labelColour == e2?.labelColour;
  }

  @override
  int hash(ChatGroupRecord? e) => const ListEquality()
      .hash([e?.createdOn, e?.createdBy, e?.groupName, e?.labelColour]);

  @override
  bool isValidKey(Object? o) => o is ChatGroupRecord;
}
