import '/backend/backend.dart';
import '/components/found_item_card/found_item_card_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'found_items_feed_widget.dart' show FoundItemsFeedWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class FoundItemsFeedModel extends FlutterFlowModel<FoundItemsFeedWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  List<ItemsRecord> simpleSearchResults = [];
  // Models for FoundItemCard.
  late FlutterFlowDynamicModels<FoundItemCardModel> foundItemCardModels;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    foundItemCardModels = FlutterFlowDynamicModels(() => FoundItemCardModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    foundItemCardModels.dispose();
  }
}
