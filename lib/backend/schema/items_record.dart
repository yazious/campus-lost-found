import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'util/firestore_util.dart';

class ItemsRecord {
  ItemsRecord._(
    this.reference,
    this._data,
  );

  final DocumentReference reference;
  final Map<String, dynamic> _data;

  String get itemId => _data['itemId'] as String? ?? '';
  String get title => _data['title'] as String? ?? '';
  String get type => _data['type'] as String? ?? '';
  String get category => _data['category'] as String? ?? '';
  String get description => _data['description'] as String? ?? '';
  String get location => _data['location'] as String? ?? '';
  DateTime? get date => _data['date'] as DateTime?;
  String get postedBy => _data['postedBy'] as String? ?? '';
  String get postedByName => _data['postedByName'] as String? ?? '';
  String get contactInfo => _data['contactInfo'] as String? ?? '';
  String get status => _data['status'] as String? ?? '';
  DateTime? get createdAt => _data['createdAt'] as DateTime?;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('items');

  static Stream<ItemsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ItemsRecord.fromSnapshot(s));

  static Future<ItemsRecord> getDocumentOnce(DocumentReference ref) async {
    final snapshot = await ref.get();
    return ItemsRecord.fromSnapshot(snapshot);
  }

  static ItemsRecord fromSnapshot(DocumentSnapshot snapshot) => ItemsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data()! as Map<String, dynamic>),
      );

  static ItemsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ItemsRecord._(reference, mapFromFirestore(data));

  Map<String, dynamic> toSerializableMap() => _data;
}

Map<String, dynamic> createItemsRecordData({
  String? itemId,
  String? title,
  String? type,
  String? category,
  String? description,
  String? location,
  DateTime? date,
  String? postedBy,
  String? postedByName,
  String? contactInfo,
  String? status,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(<String, dynamic>{
    'itemId': itemId,
    'title': title,
    'type': type,
    'category': category,
    'description': description,
    'location': location,
    'date': date,
    'postedBy': postedBy,
    'postedByName': postedByName,
    'contactInfo': contactInfo,
    'status': status,
    'createdAt': createdAt,
  }.withoutNulls);

  return firestoreData;
}

extension ItemsRecordQuery on Query {
  Query whereItemId(String? value) =>
      value != null ? where('itemId', isEqualTo: value) : this;
  Query whereTitle(String? value) =>
      value != null ? where('title', isEqualTo: value) : this;
  Query whereType(String? value) =>
      value != null ? where('type', isEqualTo: value) : this;
}

Stream<List<ItemsRecord>> queryItemsRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) {
  Query query = ItemsRecord.collection;
  if (queryBuilder != null) {
    query = queryBuilder(query);
  }
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.snapshots().map((s) => s.docs
      .map((d) => ItemsRecord.fromSnapshot(d))
      .toList());
}

Future<List<ItemsRecord>> queryItemsRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) async {
  Query query = ItemsRecord.collection;
  if (queryBuilder != null) {
    query = queryBuilder(query);
  }
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  final snapshot = await query.get();
  return snapshot.docs
      .map((d) => ItemsRecord.fromSnapshot(d))
      .toList();
}

extension _MapWithoutNulls on Map<String, dynamic> {
  Map<String, dynamic> get withoutNulls =>
      Map.fromEntries(entries.where((e) => e.value != null));
}
