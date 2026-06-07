import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/button/button_widget.dart';
import '/components/my_item_card/my_item_card_widget.dart';
import '/components/student_stat/student_stat_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'profile_my_posts_widget.dart' show ProfileMyPostsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileMyPostsModel extends FlutterFlowModel<ProfileMyPostsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for StudentStat.
  late StudentStatModel studentStatModel1;
  // Model for StudentStat.
  late StudentStatModel studentStatModel2;
  // Model for StudentStat.
  late StudentStatModel studentStatModel3;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Models for MyItemCard.
  late FlutterFlowDynamicModels<MyItemCardModel> myItemCardModels1;
  // Models for MyItemCard.
  late FlutterFlowDynamicModels<MyItemCardModel> myItemCardModels2;
  // Models for MyItemCard.
  late FlutterFlowDynamicModels<MyItemCardModel> myItemCardModels3;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    studentStatModel1 = createModel(context, () => StudentStatModel());
    studentStatModel2 = createModel(context, () => StudentStatModel());
    studentStatModel3 = createModel(context, () => StudentStatModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    myItemCardModels1 = FlutterFlowDynamicModels(() => MyItemCardModel());
    myItemCardModels2 = FlutterFlowDynamicModels(() => MyItemCardModel());
    myItemCardModels3 = FlutterFlowDynamicModels(() => MyItemCardModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    studentStatModel1.dispose();
    studentStatModel2.dispose();
    studentStatModel3.dispose();
    buttonModel1.dispose();
    myItemCardModels1.dispose();
    myItemCardModels2.dispose();
    myItemCardModels3.dispose();
    buttonModel2.dispose();
  }
}
