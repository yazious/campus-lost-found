import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'form_section_child4_model.dart';
export 'form_section_child4_model.dart';

class FormSectionChild4Widget extends StatefulWidget {
  const FormSectionChild4Widget({super.key});

  @override
  State<FormSectionChild4Widget> createState() =>
      _FormSectionChild4WidgetState();
}

class _FormSectionChild4WidgetState extends State<FormSectionChild4Widget> {
  late FormSectionChild4Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormSectionChild4Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      height: 0,
    );
  }
}
