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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'report_item_model.dart';
export 'report_item_model.dart';

class ReportItemWidget extends StatefulWidget {
  const ReportItemWidget({
    super.key,
    this.editItem,
    this.initialType,
  });

  final DocumentReference? editItem;
  final String? initialType;

  static String routeName = 'ReportItem';
  static String routePath = '/reportItem';

  @override
  State<ReportItemWidget> createState() => _ReportItemWidgetState();
}

class _ReportItemWidgetState extends State<ReportItemWidget> {
  late ReportItemModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportItemModel());
    if (widget.initialType != null && widget.initialType!.isNotEmpty) {
      _model.selectedType = widget.initialType!;
    }
    if (widget.editItem != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) => _loadEditItem());
    }
  }

  Future<void> _loadEditItem() async {
    if (widget.editItem == null) return;
    final record = await ItemsRecord.getDocumentOnce(widget.editItem!);
    if (!mounted) return;
    _model.selectedType = record.type.isNotEmpty ? record.type : 'lost';
    _model.dropdownValue = record.category.isNotEmpty
        ? record.category
        : _model.dropdownValue;
    _model.dropdownValueController ??= FormFieldController<String>(
      _model.dropdownValue,
    );
    _model.dropdownValueController!.value = _model.dropdownValue;
    _model.titleFieldModel.ensureInitialized(record.title);
    _model.titleFieldModel.inputTextController.text = record.title;
    _model.categoryFieldModel.ensureInitialized(record.description);
    _model.categoryFieldModel.inputTextController.text = record.description;
    _model.locationFieldModel.ensureInitialized(record.location);
    _model.locationFieldModel.inputTextController.text = record.location;
    _model.textFieldModel.ensureInitialized(record.contactInfo);
    _model.textFieldModel.inputTextController.text = record.contactInfo;
    if (record.date != null) {
      _model.dateFieldModel.ensureInitialized();
      _model.dateFieldModel.inputTextController.text =
          '${record.date!.day}/${record.date!.month}/${record.date!.year}';
    }
    safeSetState(() {});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () async {
                              context.goNamed(DashboardScreenWidget.routeName);
                            },
                          ),
                          Text(
                            'Report Item',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          Container(
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(24),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(16),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Item Type',
                                        style: FlutterFlowTheme.of(context).labelMedium),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => safeSetState(() => _model.selectedType = 'lost'),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              decoration: BoxDecoration(
                                                color: _model.selectedType == 'lost'
                                                    ? FlutterFlowTheme.of(context).error
                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(context).alternate,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text('Lost',
                                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                                  font: GoogleFonts.inter(),
                                                  color: _model.selectedType == 'lost'
                                                      ? Colors.white
                                                      : FlutterFlowTheme.of(context).primaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => safeSetState(() => _model.selectedType = 'found'),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              decoration: BoxDecoration(
                                                color: _model.selectedType == 'found'
                                                    ? FlutterFlowTheme.of(context).success
                                                    : FlutterFlowTheme.of(context).secondaryBackground,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(context).alternate,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text('Found',
                                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                                  font: GoogleFonts.inter(),
                                                  color: _model.selectedType == 'found'
                                                      ? Colors.white
                                                      : FlutterFlowTheme.of(context).primaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                wrapWithModel(
                                  model: _model.formSectionHeaderModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: FormSectionHeaderWidget(
                                    icon: Icon(
                                      Icons.info_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20,
                                    ),
                                    title: 'Basic Details',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.titleFieldModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    model: _model.titleFieldModel,
                                    label: 'Item Title',
                                    labelPresent: true,
                                    helper: '',
                                    helperPresent: false,
                                    hint: 'e.g., Blue Backpack, Casio Watch',
                                    value: '',
                                    onChange: '',
                                    onSubmit: '',
                                    leadingIconPresent: false,
                                    trailingIconPresent: false,
                                    variant: 'outlined',
                                    error: false,
                                  ),
                                ),
                                FlutterFlowDropDown<String>(
                                  controller: _model.dropdownValueController ??=
                                      FormFieldController<String>(
                                    _model.dropdownValue ??= 'Electronics',
                                  ),
                                  options: [
                                    'Electronics',
                                    'Documents',
                                    'Keys',
                                    'Books',
                                    'Clothing',
                                    'Other'
                                  ],
                                  onChanged: (val) => safeSetState(
                                      () => _model.dropdownValue = val),
                                  width: 200,
                                  height: 40,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.5,
                                      ),
                                  hintText: 'Electronics',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2,
                                  borderColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 1,
                                  borderRadius: 12,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                  labelText: 'Category',
                                  labelTextStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                        lineHeight: 1.3,
                                      ),
                                ),
                                wrapWithModel(
                                  model: _model.categoryFieldModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    model: _model.categoryFieldModel,
                                    label: 'Description',
                                    labelPresent: true,
                                    helper: '',
                                    helperPresent: false,
                                    hint:
                                        'Describe colors, marks, or specific details',
                                    value: '',
                                    onChange: '',
                                    onSubmit: '',
                                    leadingIconPresent: false,
                                    trailingIconPresent: false,
                                    variant: 'outlined',
                                    error: false,
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                wrapWithModel(
                                  model: _model.formSectionHeaderModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: FormSectionHeaderWidget(
                                    icon: Icon(
                                      Icons.location_on_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20,
                                    ),
                                    title: 'Time & Place',
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: wrapWithModel(
                                        model: _model.locationFieldModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: TextFieldWidget(
                                          model: _model.locationFieldModel,
                                          label: 'Location',
                                          labelPresent: true,
                                          helper: '',
                                          helperPresent: false,
                                          hint: 'e.g., Library, Cafeteria',
                                          value: '',
                                          onChange: '',
                                          onSubmit: '',
                                          leadingIconPresent: false,
                                          trailingIconPresent: false,
                                          variant: 'outlined',
                                          error: false,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: wrapWithModel(
                                        model: _model.dateFieldModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: TextFieldWidget(
                                          model: _model.dateFieldModel,
                                          label: 'Date',
                                          labelPresent: true,
                                          helper: '',
                                          helperPresent: false,
                                          hint: 'DD/MM/YYYY',
                                          value: '',
                                          onChange: '',
                                          onSubmit: '',
                                          leadingIconPresent: false,
                                          trailingIcon: Icon(
                                            Icons.calendar_today_rounded,
                                          ),
                                          trailingIconPresent: true,
                                          variant: 'outlined',
                                          error: false,
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16)),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                wrapWithModel(
                                  model: _model.formSectionHeaderModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: FormSectionHeaderWidget(
                                    icon: Icon(
                                      Icons.phone_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20,
                                    ),
                                    title: 'Contact Information',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.textFieldModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    model: _model.textFieldModel,
                                    label: 'Phone Number',
                                    labelPresent: true,
                                    helper: '',
                                    helperPresent: false,
                                    hint: '+92 3XX XXXXXXX',
                                    value: '',
                                    onChange: '',
                                    onSubmit: '',
                                    leadingIcon: Icon(
                                      Icons.phone_android_rounded,
                                    ),
                                    leadingIconPresent: true,
                                    trailingIconPresent: false,
                                    variant: 'outlined',
                                    error: false,
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      final title = _model.titleFieldModel
                                          .inputTextController.text
                                          .trim();
                                      if (title.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Please enter an item title'),
                                          ),
                                        );
                                        return;
                                      }

                                      if (_model.isSaving) return;
                                      safeSetState(() => _model.isSaving = true);

                                      try {
                                        if (widget.editItem != null) {
                                          await widget.editItem!.update(
                                            createItemsRecordData(
                                              title: title,
                                              type: _model.selectedType,
                                              category: _model.dropdownValue ??
                                                  'Other',
                                              description: _model
                                                  .categoryFieldModel
                                                  .inputTextController
                                                  .text,
                                              location: _model
                                                  .locationFieldModel
                                                  .inputTextController
                                                  .text,
                                              contactInfo: _model
                                                  .textFieldModel
                                                  .inputTextController
                                                  .text,
                                            ),
                                          );
                                        } else {
                                          final docRef =
                                              ItemsRecord.collection.doc();
                                          await docRef.set(
                                            createItemsRecordData(
                                              itemId: docRef.id,
                                              title: title,
                                              type: _model.selectedType,
                                              category:
                                                  _model.dropdownValue ??
                                                      'Other',
                                              description: _model
                                                  .categoryFieldModel
                                                  .inputTextController
                                                  .text,
                                              location: _model
                                                  .locationFieldModel
                                                  .inputTextController
                                                  .text,
                                              date: getCurrentTimestamp,
                                              postedBy: currentUserUid,
                                              postedByName:
                                                  currentUserDisplayName,
                                              contactInfo: _model
                                                  .textFieldModel
                                                  .inputTextController
                                                  .text,
                                              status: 'active',
                                              createdAt: getCurrentTimestamp,
                                            ),
                                          );
                                        }
                                        if (!context.mounted) return;
                                        context.safePop();
                                      } finally {
                                        if (mounted) {
                                          safeSetState(
                                              () => _model.isSaving = false);
                                        }
                                      }
                                    },
                                    child: wrapWithModel(
                                      model: _model.buttonModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ButtonWidget(
                                        content: 'Post Report',
                                        iconPresent: false,
                                        iconEndPresent: false,
                                        variant: 'primary',
                                        size: 'large',
                                        fullWidth: true,
                                        loading: false,
                                        disabled: false,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Your post will be visible to all BUITEMS students.',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 16)),
                              ),
                            ),
                          ].divide(SizedBox(height: 24)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      child: Container(
                        height: 47,
                        alignment: AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                        DashboardScreenWidget.routeName);
                                  },
                                  child: Icon(
                                    Icons.home_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
                                  ),
                                ),
                                Text(
                                  'Home',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                        lineHeight: 1.2,
                                      ),
                                ),
                              ].divide(SizedBox(height: 4)),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context
                                    .pushNamed(LostItemsFeedWidget.routeName);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                          LostItemsFeedWidget.routeName);
                                    },
                                    child: Icon(
                                      Icons.search_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    'Lost',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.2,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 4)),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                        FoundItemsFeedWidget.routeName);
                                  },
                                  child: Icon(
                                    Icons.help,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
                                  ),
                                ),
                                Text(
                                  'Found',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                        lineHeight: 1.2,
                                      ),
                                ),
                              ].divide(SizedBox(height: 4)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      ReportItemWidget.routeName,
                                      queryParameters: {
                                        'editItem': serializeParam(
                                          widget!.editItem,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Icon(
                                    Icons.add_circle_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24,
                                  ),
                                ),
                                Text(
                                  'Add',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                        lineHeight: 1.2,
                                      ),
                                ),
                              ].divide(SizedBox(height: 4)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                        ProfileMyPostsWidget.routeName);
                                  },
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
                                  ),
                                ),
                                Text(
                                  'Profile',
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                        lineHeight: 1.2,
                                      ),
                                ),
                              ].divide(SizedBox(height: 4)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}