import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/button/button_widget.dart';
import '/components/form_section_header/form_section_header_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'report_item_widget.dart' show ReportItemWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReportItemModel extends FlutterFlowModel<ReportItemWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for FormSectionHeader.
  late FormSectionHeaderModel formSectionHeaderModel1;
  // Model for titleField.
  late TextFieldModel titleFieldModel;
  // State field(s) for Dropdown widget.
  String? dropdownValue;
  FormFieldController<String>? dropdownValueController;
  // Model for categoryField.
  late TextFieldModel categoryFieldModel;
  // Model for FormSectionHeader.
  late FormSectionHeaderModel formSectionHeaderModel2;
  // Model for locationField.
  late TextFieldModel locationFieldModel;
  // Model for dateField.
  late TextFieldModel dateFieldModel;
  // Model for FormSectionHeader.
  late FormSectionHeaderModel formSectionHeaderModel3;
  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    formSectionHeaderModel1 =
        createModel(context, () => FormSectionHeaderModel());
    titleFieldModel = createModel(context, () => TextFieldModel());
    categoryFieldModel = createModel(context, () => TextFieldModel());
    formSectionHeaderModel2 =
        createModel(context, () => FormSectionHeaderModel());
    locationFieldModel = createModel(context, () => TextFieldModel());
    dateFieldModel = createModel(context, () => TextFieldModel());
    formSectionHeaderModel3 =
        createModel(context, () => FormSectionHeaderModel());
    textFieldModel = createModel(context, () => TextFieldModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    formSectionHeaderModel1.dispose();
    titleFieldModel.dispose();
    categoryFieldModel.dispose();
    formSectionHeaderModel2.dispose();
    locationFieldModel.dispose();
    dateFieldModel.dispose();
    formSectionHeaderModel3.dispose();
    textFieldModel.dispose();
    buttonModel.dispose();
  }
}
