import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'util/firestore_util.dart';

class UsersRecord {
  UsersRecord._(
    this.reference,
    this._data,
  );

  final DocumentReference reference;
  final Map<String, dynamic> _data;

  String? get userID => _data['UserID'] as String?;
  String? get department => _data['department'] as String?;
  String? get name => _data['name'] as String?;
  String? get role => _data['role'] as String?;
  DateTime? get createdAt => _data['createdAt'] as DateTime?;
  DateTime? get createdTime => _data['createdTime'] as DateTime?;
  String? get displayName => _data['displayName'] as String?;
  String? get email => _data['email'] as String?;
  String? get uid => _data['uid'] as String?;
  String? get phoneNumber => _data['phoneNumber'] as String?;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data()! as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));
}

Map<String, dynamic> createUsersRecordData({
  String? userID,
  String? department,
  String? name,
  String? role,
  DateTime? createdAt,
  DateTime? createdTime,
  String? displayName,
  String? email,
  String? uid,
  String? phoneNumber,
}) {
  final firestoreData = mapToFirestore(<String, dynamic>{
    'UserID': userID,
    'department': department,
    'name': name,
    'role': role,
    'createdAt': createdAt,
    'createdTime': createdTime,
    'displayName': displayName,
    'email': email,
    'uid': uid,
    'phoneNumber': phoneNumber,
  }.withoutNulls);

  return firestoreData;
}

Stream<List<UsersRecord>> queryUsersRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) {
  Query query = UsersRecord.collection;
  if (queryBuilder != null) {
    query = queryBuilder(query);
  }
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.snapshots().map((s) => s.docs
      .map((d) => UsersRecord.fromSnapshot(d))
      .toList());
}

extension _MapWithoutNulls on Map<String, dynamic> {
  Map<String, dynamic> get withoutNulls =>
      Map.fromEntries(entries.where((e) => e.value != null));
}
