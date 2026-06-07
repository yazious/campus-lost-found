import '/components/tab_group/tab_group_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'itemtypr_model.dart';
export 'itemtypr_model.dart';

class ItemtyprWidget extends StatefulWidget {
  const ItemtyprWidget({super.key});

  @override
  State<ItemtyprWidget> createState() => _ItemtyprWidgetState();
}

class _ItemtyprWidgetState extends State<ItemtyprWidget> {
  late ItemtyprModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ItemtyprModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'What happened?',
          style: FlutterFlowTheme.of(context).labelLarge.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelLarge.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                lineHeight: 1.3,
              ),
        ),
        wrapWithModel(
          model: _model.itemTypeFieldModel,
          updateCallback: () => safeSetState(() {}),
          child: TabGroupWidget(
            label1: 'Lost Item',
            label2: 'Found Item',
            label2Present: true,
            label3: 'Reports',
            label3Present: true,
            label4: '',
            label4Present: false,
            label5: '',
            label5Present: false,
          ),
        ),
      ].divide(SizedBox(height: 16)),
    );
  }
}
