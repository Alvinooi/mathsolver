import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessageRecord extends FirestoreRecord {
  MessageRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  bool hasContent() => _content != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "createdOn" field.
  String? _createdOn;
  String get createdOn => _createdOn ?? '';
  bool hasCreatedOn() => _createdOn != null;

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "chat" field.
  DocumentReference? _chat;
  DocumentReference? get chat => _chat;
  bool hasChat() => _chat != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _content = snapshotData['content'] as String?;
    _status = snapshotData['status'] as String?;
    _createdOn = snapshotData['createdOn'] as String?;
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _chat = snapshotData['chat'] as DocumentReference?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('message');

  static Stream<MessageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MessageRecord.fromSnapshot(s));

  static Future<MessageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MessageRecord.fromSnapshot(s));

  static MessageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MessageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MessageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MessageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MessageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MessageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMessageRecordData({
  String? content,
  String? status,
  String? createdOn,
  DocumentReference? createdBy,
  DocumentReference? chat,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'content': content,
      'status': status,
      'createdOn': createdOn,
      'createdBy': createdBy,
      'chat': chat,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class MessageRecordDocumentEquality implements Equality<MessageRecord> {
  const MessageRecordDocumentEquality();

  @override
  bool equals(MessageRecord? e1, MessageRecord? e2) {
    return e1?.content == e2?.content &&
        e1?.status == e2?.status &&
        e1?.createdOn == e2?.createdOn &&
        e1?.createdBy == e2?.createdBy &&
        e1?.chat == e2?.chat &&
        e1?.type == e2?.type;
  }

  @override
  int hash(MessageRecord? e) => const ListEquality().hash(
      [e?.content, e?.status, e?.createdOn, e?.createdBy, e?.chat, e?.type]);

  @override
  bool isValidKey(Object? o) => o is MessageRecord;
}
