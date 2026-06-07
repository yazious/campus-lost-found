import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'form_card_child2_model.dart';
export 'form_card_child2_model.dart';

class FormCardChild2Widget extends StatefulWidget {
  const FormCardChild2Widget({super.key});

  @override
  State<FormCardChild2Widget> createState() => _FormCardChild2WidgetState();
}

class _FormCardChild2WidgetState extends State<FormCardChild2Widget> {
  late FormCardChild2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormCardChild2Model());
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
