import '/backend/backend.dart';
import '/components/button/button_widget.dart';
import '/components/quick_action/quick_action_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'dashboard_screen_widget.dart' show DashboardScreenWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardScreenModel extends FlutterFlowModel<DashboardScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for QuickAction.
  late QuickActionModel quickActionModel1;
  // Model for QuickAction.
  late QuickActionModel quickActionModel2;
  // Model for QuickAction.
  late QuickActionModel quickActionModel3;
  // Model for QuickAction.
  late QuickActionModel quickActionModel4;
  // Models for Button.
  late FlutterFlowDynamicModels<ButtonModel> buttonModels;

  @override
  void initState(BuildContext context) {
    quickActionModel1 = createModel(context, () => QuickActionModel());
    quickActionModel2 = createModel(context, () => QuickActionModel());
    quickActionModel3 = createModel(context, () => QuickActionModel());
    quickActionModel4 = createModel(context, () => QuickActionModel());
    buttonModels = FlutterFlowDynamicModels(() => ButtonModel());
  }

  @override
  void dispose() {
    quickActionModel1.dispose();
    quickActionModel2.dispose();
    quickActionModel3.dispose();
    quickActionModel4.dispose();
    buttonModels.dispose();
  }
}
