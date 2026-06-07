import '/components/tab_group/tab_group_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'itemtypr_widget.dart' show ItemtyprWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemtyprModel extends FlutterFlowModel<ItemtyprWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for itemTypeField.
  late TabGroupModel itemTypeFieldModel;

  @override
  void initState(BuildContext context) {
    itemTypeFieldModel = createModel(context, () => TabGroupModel());
  }

  @override
  void dispose() {
    itemTypeFieldModel.dispose();
  }
}
