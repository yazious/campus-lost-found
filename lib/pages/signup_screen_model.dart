import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/button/button_widget.dart';
import '/components/checkbox/checkbox_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'signup_screen_widget.dart' show SignupScreenWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupScreenModel extends FlutterFlowModel<SignupScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for fullNameField.
  late TextFieldModel fullNameFieldModel;
  // Model for emailField.
  late TextFieldModel emailFieldModel;
  // State field(s) for Dropdown widget.
  String? dropdownValue1;
  FormFieldController<String>? dropdownValueController1;
  // State field(s) for Dropdown widget.
  String? dropdownValue2;
  FormFieldController<String>? dropdownValueController2;
  // Model for phoneField.
  late TextFieldModel phoneFieldModel;
  // Model for passwordField.
  late TextFieldModel passwordFieldModel;
  // Model for Checkbox.
  late CheckboxModel checkboxModel;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    fullNameFieldModel = createModel(context, () => TextFieldModel());
    emailFieldModel = createModel(context, () => TextFieldModel());
    phoneFieldModel = createModel(context, () => TextFieldModel());
    passwordFieldModel = createModel(context, () => TextFieldModel());
    checkboxModel = createModel(context, () => CheckboxModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    fullNameFieldModel.dispose();
    emailFieldModel.dispose();
    phoneFieldModel.dispose();
    passwordFieldModel.dispose();
    checkboxModel.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
