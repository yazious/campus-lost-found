import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'form_card_child3_model.dart';
export 'form_card_child3_model.dart';

class FormCardChild3Widget extends StatefulWidget {
  const FormCardChild3Widget({super.key});

  @override
  State<FormCardChild3Widget> createState() => _FormCardChild3WidgetState();
}

class _FormCardChild3WidgetState extends State<FormCardChild3Widget> {
  late FormCardChild3Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormCardChild3Model());
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
