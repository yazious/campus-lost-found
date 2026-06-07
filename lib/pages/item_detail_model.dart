import '/backend/backend.dart';
import '/components/button/button_widget.dart';
import '/components/info_tag/info_tag_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'item_detail_widget.dart' show ItemDetailWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemDetailModel extends FlutterFlowModel<ItemDetailWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for InfoTag.
  late InfoTagModel infoTagModel;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    infoTagModel = createModel(context, () => InfoTagModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    infoTagModel.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
