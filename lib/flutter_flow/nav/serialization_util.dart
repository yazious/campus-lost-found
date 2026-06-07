import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String? serializeParam(
  dynamic param,
  ParamType paramType, {
  bool isList = false,
}) {
  if (param == null) {
    return null;
  }
  if (isList) {
  final serializedValues = (param as Iterable)
      .map((p) => serializeParam(p, paramType))
      .where((p) => p != null)
      .map((p) => p!)
      .toList();
    return json.encode(serializedValues);
  }
  switch (paramType) {
    case ParamType.int:
      return param.toString();
    case ParamType.double:
      return param.toString();
    case ParamType.String:
      return param as String;
    case ParamType.bool:
      return param ? 'true' : 'false';
    case ParamType.DateTime:
      return (param as DateTime).millisecondsSinceEpoch.toString();
    case ParamType.DateTimeRange:
      final range = param as DateTimeRange;
      return json.encode({
        'start': range.start.millisecondsSinceEpoch,
        'end': range.end.millisecondsSinceEpoch,
      });
    case ParamType.LatLng:
      return (param as dynamic).serialize();
    case ParamType.Color:
      return (param as Color).value.toString();
    case ParamType.FFPlace:
      return json.encode((param as dynamic).toMap());
    case ParamType.FFUploadedFile:
      return json.encode((param as dynamic).toMap());
    case ParamType.JSON:
      return json.encode(param);
    case ParamType.DocumentReference:
      return (param as DocumentReference).path;
    case ParamType.Document:
      final ref = (param as dynamic).reference as DocumentReference?;
      return ref?.path;
  }
}

dynamic deserializeParam<T>(
  String? param,
  ParamType paramType,
  bool isList, {
  List<String>? collectionNamePath,
}) {
  if (param == null) {
    return null;
  }
  if (isList) {
    final paramValues = json.decode(param) as Iterable;
    return paramValues
        .map((p) => deserializeParam<T>(p, paramType, false,
            collectionNamePath: collectionNamePath))
        .where((p) => p != null)
        .map((p) => p! as T)
        .toList();
  }
  switch (paramType) {
    case ParamType.int:
      return int.tryParse(param);
    case ParamType.double:
      return double.tryParse(param);
    case ParamType.String:
      return param;
    case ParamType.bool:
      return param == 'true';
    case ParamType.DateTime:
      return DateTime.fromMillisecondsSinceEpoch(int.parse(param));
    case ParamType.DateTimeRange:
      final range = json.decode(param) as Map<String, dynamic>;
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(range['start'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(range['end'] as int),
      );
    case ParamType.LatLng:
      return null;
    case ParamType.Color:
      return Color(int.parse(param));
    case ParamType.FFPlace:
      return null;
    case ParamType.FFUploadedFile:
      return null;
    case ParamType.JSON:
      return json.decode(param);
    case ParamType.DocumentReference:
      if (collectionNamePath != null && collectionNamePath.isNotEmpty) {
        return FirebaseFirestore.instance
            .collection(collectionNamePath.first)
            .doc(param);
      }
      return FirebaseFirestore.instance.doc(param);
    case ParamType.Document:
      return null;
  }
}

enum ParamType {
  int,
  double,
  String,
  bool,
  DateTime,
  DateTimeRange,
  LatLng,
  Color,
  FFPlace,
  FFUploadedFile,
  JSON,
  DocumentReference,
  Document,
}

extension MapExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}
