import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatRecord extends FirestoreRecord {
  ChatRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "chatName" field.
  String? _chatName;
  String get chatName => _chatName ?? '';
  bool hasChatName() => _chatName != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "createdOn" field.
  DateTime? _createdOn;
  DateTime? get createdOn => _createdOn;
  bool hasCreatedOn() => _createdOn != null;

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "groupID" field.
  DocumentReference? _groupID;
  DocumentReference? get groupID => _groupID;
  bool hasGroupID() => _groupID != null;

  // "members" field.
  List<DocumentReference>? _members;
  List<DocumentReference> get members => _members ?? const [];
  bool hasMembers() => _members != null;

  // "updatedOn" field.
  DateTime? _updatedOn;
  DateTime? get updatedOn => _updatedOn;
  bool hasUpdatedOn() => _updatedOn != null;

  void _initializeFields() {
    _chatName = snapshotData['chatName'] as String?;
    _status = snapshotData['status'] as String?;
    _createdOn = snapshotData['createdOn'] as DateTime?;
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _groupID = snapshotData['groupID'] as DocumentReference?;
    _members = getDataList(snapshotData['members']);
    _updatedOn = snapshotData['updatedOn'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chat');

  static Stream<ChatRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatRecord.fromSnapshot(s));

  static Future<ChatRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatRecord.fromSnapshot(s));

  static ChatRecord fromSnapshot(DocumentSnapshot snapshot) => ChatRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatRecordData({
  String? chatName,
  String? status,
  DateTime? createdOn,
  DocumentReference? createdBy,
  DocumentReference? groupID,
  DateTime? updatedOn,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'chatName': chatName,
      'status': status,
      'createdOn': createdOn,
      'createdBy': createdBy,
      'groupID': groupID,
      'updatedOn': updatedOn,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatRecordDocumentEquality implements Equality<ChatRecord> {
  const ChatRecordDocumentEquality();

  @override
  bool equals(ChatRecord? e1, ChatRecord? e2) {
    const listEquality = ListEquality();
    return e1?.chatName == e2?.chatName &&
        e1?.status == e2?.status &&
        e1?.createdOn == e2?.createdOn &&
        e1?.createdBy == e2?.createdBy &&
        e1?.groupID == e2?.groupID &&
        listEquality.equals(e1?.members, e2?.members) &&
        e1?.updatedOn == e2?.updatedOn;
  }

  @override
  int hash(ChatRecord? e) => const ListEquality().hash([
        e?.chatName,
        e?.status,
        e?.createdOn,
        e?.createdBy,
        e?.groupID,
        e?.members,
        e?.updatedOn
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatRecord;
}
