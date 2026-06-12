import '/components/lost_item_card/lost_item_card_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lost_items_feed_widget.dart' show LostItemsFeedWidget;
import 'package:flutter/material.dart';

import '/backend/backend.dart';

class LostItemsFeedModel extends FlutterFlowModel<LostItemsFeedWidget> {
  ///  Local state fields for this page.

  String selectedCategory = 'all';

  ///  State fields for stateful widgets in this page.

  // Model for searchField.
  late TextFieldModel searchFieldModel;
  List<ItemsRecord> simpleSearchResults = [];
  // Models for LostItemCard.
  late FlutterFlowDynamicModels<LostItemCardModel> lostItemCardModels1;

  @override
  void initState(BuildContext context) {
    searchFieldModel = createModel(context, () => TextFieldModel());
    lostItemCardModels1 = FlutterFlowDynamicModels(() => LostItemCardModel());
  }

  @override
  void dispose() {
    searchFieldModel.dispose();
    lostItemCardModels1.dispose();
  }
}
