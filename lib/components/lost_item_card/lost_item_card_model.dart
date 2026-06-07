import '/backend/firebase_storage/storage.dart';
import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:typed_data';
import 'dart:ui';
import '/index.dart';
import 'lost_item_card_widget.dart' show LostItemCardWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LostItemCardModel extends FlutterFlowModel<LostItemCardWidget> {
  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataGh4 = false;
  FFUploadedFile uploadedLocalFile_uploadDataGh4 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataGh4 = '';

  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
