import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'form_card_model.dart';
export 'form_card_model.dart';

class FormCardWidget extends StatefulWidget {
  const FormCardWidget({
    super.key,
    this.child,
  });

  final Widget Function()? child;

  @override
  State<FormCardWidget> createState() => _FormCardWidgetState();
}

class _FormCardWidgetState extends State<FormCardWidget> {
  late FormCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Container(
          child: Builder(builder: (_) {
            return widget.child != null ? widget.child!() : SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}
