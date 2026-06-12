import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'text_field_widget.dart' show TextFieldWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TextFieldModel extends FlutterFlowModel<TextFieldWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Input widget.
  late FocusNode inputFocusNode;
  late TextEditingController inputTextController;
  bool hasInitializedControllers = false;
  String? Function(BuildContext, String?)? inputTextControllerValidator;

  void ensureInitialized([String value = '']) {
    if (!hasInitializedControllers) {
      inputTextController = TextEditingController(text: value);
      inputFocusNode = FocusNode();
      hasInitializedControllers = true;
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    if (hasInitializedControllers) {
      inputFocusNode.dispose();
      inputTextController.dispose();
    }
  }
}
