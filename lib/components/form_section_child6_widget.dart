import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'form_section_child6_model.dart';
export 'form_section_child6_model.dart';

class FormSectionChild6Widget extends StatefulWidget {
  const FormSectionChild6Widget({super.key});

  @override
  State<FormSectionChild6Widget> createState() =>
      _FormSectionChild6WidgetState();
}

class _FormSectionChild6WidgetState extends State<FormSectionChild6Widget> {
  late FormSectionChild6Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormSectionChild6Model());
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
