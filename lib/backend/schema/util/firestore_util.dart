import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, dynamic> mapFromFirestore(Map<String, dynamic> data) {
  return data.map((key, value) {
    if (value is Timestamp) {
      return MapEntry(key, value.toDate());
    }
    if (value is Iterable) {
      return MapEntry(key, value.toList());
    }
    if (value is Map) {
      return MapEntry(key, mapFromFirestore(Map<String, dynamic>.from(value)));
    }
    return MapEntry(key, value);
  });
}

Map<String, dynamic> mapToFirestore(Map<String, dynamic> data) {
  return data.map((key, value) {
    if (value is DateTime) {
      return MapEntry(key, Timestamp.fromDate(value));
    }
    if (value is Map) {
      return MapEntry(
        key,
        mapToFirestore(Map<String, dynamic>.from(value)),
      );
    }
    return MapEntry(key, value);
  })..removeWhere((k, v) => k == 'reference');
}

Map<String, dynamic> mergeNestedFields(Map<String, dynamic> data) {
  final merged = <String, dynamic>{};
  data.forEach((key, value) {
    if (value is Map) {
      merged.addAll(value.map((k, v) => MapEntry('$key.$k', v)));
    } else {
      merged[key] = value;
    }
  });
  return merged;
}

extension FirestoreUtilExtensions on DocumentReference {
  DocumentReference withConverter<T>(
    T Function(DocumentSnapshot snapshot) fromFirestore,
    Map<String, dynamic> Function(T value) toFirestore,
  ) =>
      this;
}

List<String> getDocumentPaths(List<DocumentReference> refs) =>
    refs.map((r) => r.path).toList();

extension QueryExtension on Query {
  Query whereIn(String field, List? list) => (list?.isEmpty ?? true)
      ? where(field, whereIn: null)
      : where(field, whereIn: list);
}

extension CollectionReferenceExtensions on CollectionReference {
  DocumentReference docOrAdd(Map<String, dynamic> data) => doc();
}
