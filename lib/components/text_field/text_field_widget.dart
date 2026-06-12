import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'text_field_model.dart';
export 'text_field_model.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.model,
    String? label,
    bool? labelPresent,
    String? helper,
    bool? helperPresent,
    String? hint,
    String? value,
    String? onChange,
    String? onSubmit,
    this.leadingIcon,
    bool? leadingIconPresent,
    this.trailingIcon,
    bool? trailingIconPresent,
    String? variant,
    bool? error,
  })  : this.label = label ?? 'Email',
        this.labelPresent = labelPresent ?? true,
        this.helper = helper ?? '',
        this.helperPresent = helperPresent ?? false,
        this.hint = hint ?? 'student.id@buitems.edu.pk',
        this.value = value ?? '',
        this.onChange = onChange ?? '',
        this.onSubmit = onSubmit ?? '',
        this.leadingIconPresent = leadingIconPresent ?? true,
        this.trailingIconPresent = trailingIconPresent ?? false,
        this.variant = variant ?? 'outlined',
        this.error = error ?? false;

  final TextFieldModel model;
  final String label;
  final bool labelPresent;
  final String helper;
  final bool helperPresent;
  final String hint;
  final String value;
  final String onChange;
  final String onSubmit;
  final Widget? leadingIcon;
  final bool leadingIconPresent;
  final Widget? trailingIcon;
  final bool trailingIconPresent;
  final String variant;
  final bool error;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextFieldModel _model;
  bool _obscureText = false;
  bool _isPasswordField = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = widget.model;

    _model.ensureInitialized(widget.value);

    _isPasswordField = widget.label.toLowerCase().contains('password') ||
        widget.hint.toLowerCase().contains('password');
    _obscureText = widget.trailingIconPresent && _isPasswordField;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (valueOrDefault<bool>(
            widget.labelPresent,
            true,
          ))
            Text(
              valueOrDefault<String>(
                widget.label,
                'Email',
              ),
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
                    color: widget.error
                        ? FlutterFlowTheme.of(context).error
                        : FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).labelMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    lineHeight: 1.3,
                  ),
            ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: () {
                if (widget.variant == 'filled') {
                  return FlutterFlowTheme.of(context).secondaryBackground;
                } else if (widget.variant == 'ghost') {
                  return Colors.transparent;
                } else {
                  return Colors.transparent;
                }
              }(),
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: () {
                  if (widget.error) {
                    return FlutterFlowTheme.of(context).error;
                  } else if (widget.variant == 'filled') {
                    return Colors.transparent;
                  } else if (widget.variant == 'ghost') {
                    return Colors.transparent;
                  } else {
                    return FlutterFlowTheme.of(context).alternate;
                  }
                }(),
                width: () {
                  if (widget.error) {
                    return 1.0;
                  } else if (widget.variant == 'filled') {
                    return 1.0;
                  } else if (widget.variant == 'ghost') {
                    return 0.0;
                  } else {
                    return 1.0;
                  }
                }(),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (valueOrDefault<bool>(
                        widget.leadingIconPresent,
                        true,
                      ) &&
                      widget.leadingIcon != null)
                    widget.leadingIcon!,
                  if (valueOrDefault<bool>(
                        widget.leadingIconPresent,
                        true,
                      ) &&
                      widget.leadingIcon != null)
                    SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _model.inputTextController,
                      focusNode: _model.inputFocusNode,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: valueOrDefault<String>(
                          widget.hint,
                          'student.id@buitems.edu.pk',
                        ),
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).accent3,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                              lineHeight: 1.5,
                            ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                            lineHeight: 1.5,
                          ),
                      validator: _model.inputTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  if (widget.trailingIcon != null)
                    widget.trailingIcon!
                  else if (valueOrDefault<bool>(
                    widget.trailingIconPresent,
                    false,
                  ))
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (valueOrDefault<bool>(
            widget.helperPresent,
            false,
          ))
            Text(
              widget.helper,
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodySmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodySmall.fontStyle,
                    ),
                    color: widget.error
                        ? FlutterFlowTheme.of(context).error
                        : FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodySmall.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                    lineHeight: 1.4,
                  ),
            ),
        ].divide(SizedBox(height: 6)),
      ),
    );
  }
}
