import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

import '../backend/firebase_storage/storage.dart';

const allowedFormats = {'image/png', 'image/jpeg', 'image/jpg', 'image/gif'};

class FFUploadedFile {
  const FFUploadedFile({
    this.name,
    this.bytes,
    this.height,
    this.width,
    this.blurHash,
    this.originalFilename,
  });

  final String? name;
  final Uint8List? bytes;
  final String? originalFilename;
  final double? height;
  final double? width;
  final String? blurHash;

  Map<String, dynamic> toMap() => {
        'name': name,
        'bytes': bytes,
        'height': height,
        'width': width,
        'blurHash': blurHash,
      };
}

class SelectedFile {
  const SelectedFile({
    required this.storagePath,
    required this.bytes,
    this.dimensions,
    this.blurHash,
    String? originalFilename,
  }) : _originalFilename = originalFilename;

  final String storagePath;
  final Uint8List bytes;
  final MediaDimensions? dimensions;
  final String? blurHash;
  final String? _originalFilename;

  String get originalFilename =>
      _originalFilename ?? storagePath.split('/').last;
}

class MediaDimensions {
  const MediaDimensions({this.height, this.width});

  final double? height;
  final double? width;
}

Future<List<SelectedFile>?> selectMediaWithSourceBottomSheet({
  required BuildContext context,
  String? storageFolderPath,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  bool allowPhoto = true,
  bool allowVideo = false,
  String pickerFontFamily = 'Roboto',
  Color textColor = const Color(0xFF111417),
  Color backgroundColor = const Color(0xFFF5F5F5),
  bool includeDimensions = false,
  bool includeBlurHash = false,
}) async {
  final source = await showModalBottomSheet<MediaSource>(
    context: context,
    backgroundColor: backgroundColor,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (allowPhoto)
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('Choose Photo', style: TextStyle(color: textColor)),
              onTap: () => Navigator.pop(context, MediaSource.photoGallery),
            ),
          if (allowPhoto)
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text('Take Photo', style: TextStyle(color: textColor)),
              onTap: () => Navigator.pop(context, MediaSource.camera),
            ),
        ],
      ),
    ),
  );
  if (source == null) {
    return null;
  }

  final picker = ImagePicker();
  final pickedFiles = source == MediaSource.camera
      ? [await picker.pickImage(source: ImageSource.camera)]
      : await picker.pickMultiImage();

  final files = <SelectedFile>[];
  for (final file in pickedFiles.whereType<XFile>()) {
    final bytes = await file.readAsBytes();
    final fileName = file.name;
    final storagePath = storageFolderPath != null
        ? '$storageFolderPath/$fileName'
        : fileName;
    files.add(
      SelectedFile(
        storagePath: storagePath,
        bytes: bytes,
      ),
    );
  }
  return files.isEmpty ? null : files;
}

enum MediaSource { photoGallery, camera }

bool validateFileFormat(String storagePath, BuildContext context) {
  final mimeTypeStr = mime(storagePath.split('.').last) ?? '';
  if (!allowedFormats.contains(mimeTypeStr)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid file format')),
    );
    return false;
  }
  return true;
}

Future<String?> uploadData(String path, Uint8List data) =>
    uploadFirebaseStorage(path: path, data: data);
