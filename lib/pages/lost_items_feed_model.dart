import '/backend/backend.dart';
import '/components/category_chip/category_chip_widget.dart';
import '/components/lost_item_card/lost_item_card_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'lost_items_feed_widget.dart' show LostItemsFeedWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class LostItemsFeedModel extends FlutterFlowModel<LostItemsFeedWidget> {
  ///  Local state fields for this page.

  String selectedCategory = 'all';

  ///  State fields for stateful widgets in this page.

  // Model for searchField.
  late TextFieldModel searchFieldModel;
  List<ItemsRecord> simpleSearchResults = [];
  // Models for LostItemCard.
  late FlutterFlowDynamicModels<LostItemCardModel> lostItemCardModels1;
  // Models for LostItemCard.
  late FlutterFlowDynamicModels<LostItemCardModel> lostItemCardModels2;
  // Models for LostItemCard.
  late FlutterFlowDynamicModels<LostItemCardModel> lostItemCardModels3;
  // Models for LostItemCard.
  late FlutterFlowDynamicModels<LostItemCardModel> lostItemCardModels4;

  @override
  void initState(BuildContext context) {
    searchFieldModel = createModel(context, () => TextFieldModel());
    lostItemCardModels1 = FlutterFlowDynamicModels(() => LostItemCardModel());
    lostItemCardModels2 = FlutterFlowDynamicModels(() => LostItemCardModel());
    lostItemCardModels3 = FlutterFlowDynamicModels(() => LostItemCardModel());
    lostItemCardModels4 = FlutterFlowDynamicModels(() => LostItemCardModel());
  }

  @override
  void dispose() {
    searchFieldModel.dispose();
    lostItemCardModels1.dispose();
    lostItemCardModels2.dispose();
    lostItemCardModels3.dispose();
    lostItemCardModels4.dispose();
  }
}
