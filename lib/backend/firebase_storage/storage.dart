import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';

Future<String?> uploadFirebaseStorage({
  required String path,
  required Uint8List data,
}) async {
  final storageRef = FirebaseStorage.instance.ref().child(path);
  final metadata = SettableMetadata(contentType: mime(path));
  final result = await storageRef.putData(data, metadata);
  return result.ref.getDownloadURL();
}

Future deleteUploadedFile(String fileUrl) async {
  try {
    final ref = FirebaseStorage.instance.refFromURL(fileUrl);
    await ref.delete();
  } catch (_) {}
}
