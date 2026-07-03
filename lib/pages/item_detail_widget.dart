import '/backend/backend.dart';
import '/components/button/button_widget.dart';
import '/components/info_tag/info_tag_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'item_detail_model.dart';
export 'item_detail_model.dart';

class ItemDetailWidget extends StatefulWidget {
  const ItemDetailWidget({
    super.key,
    required this.itemRef,
  });

  final DocumentReference? itemRef;

  static String routeName = 'ItemDetail';
  static String routePath = '/itemDetail';

  @override
  State<ItemDetailWidget> createState() => _ItemDetailWidgetState();
}

class _ItemDetailWidgetState extends State<ItemDetailWidget> {
  late ItemDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // FIXED: store contactInfo in state so it's accessible outside the StreamBuilder
  String _contactInfo = '';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ItemDetailModel());
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
        body: Stack(
          alignment: AlignmentDirectional(-1, -1),
          children: [
            StreamBuilder<ItemsRecord>(
              stream: ItemsRecord.getDocument(widget!.itemRef!),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }

                final columnItemsRecord = snapshot.data!;

                // FIXED: update _contactInfo whenever stream emits new data
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted &&
                      _contactInfo != columnItemsRecord.contactInfo) {
                    setState(() {
                      _contactInfo = columnItemsRecord.contactInfo;
                    });
                  }
                });

                return SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 100),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 340,
                                child: Stack(
                                  alignment: AlignmentDirectional(-1, -1),
                                  children: [
                                    CachedNetworkImage(
                                      fadeInDuration:
                                          Duration(milliseconds: 0),
                                      fadeOutDuration:
                                          Duration(milliseconds: 0),
                                      imageUrl:
                                          'https://dimg.dreamflow.cloud/v1/image/lost%20black%20leather%20wallet%20with%20university%20ID%20card',
                                      height: 340,
                                      fit: BoxFit.cover,
                                      alignment: Alignment(0, 0),
                                    ),
                                    Container(
                                      height: 340,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            FlutterFlowTheme.of(context)
                                                .primaryBackground
                                          ],
                                          stops: [0.6, 1],
                                          begin: AlignmentDirectional(0, -1),
                                          end: AlignmentDirectional(0, 1),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-1, -1),
                                      child: Padding(
                                        padding: EdgeInsets.all(24),
                                        child: FlutterFlowIconButton(
                                          borderRadius: 9999,
                                          buttonSize: 40,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .surface80,
                                          icon: Icon(
                                            Icons.arrow_back_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24,
                                          ),
                                          onPressed: () async {
                                            context.goNamed(
                                                DashboardScreenWidget
                                                    .routeName);
                                          },
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(1, -1),
                                      child: Padding(
                                        padding: EdgeInsets.all(24),
                                        child: wrapWithModel(
                                          model: _model.infoTagModel,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: InfoTagWidget(
                                            bg: Color(0x00000000),
                                            color: Color(0x00000000),
                                            icon: Icon(
                                              Icons.history_rounded,
                                              size: 14,
                                            ),
                                            label: 'STILL LOST',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                            child: Text(
                                              columnItemsRecord.title,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineMedium
                                                  .override(
                                                    font: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineMedium
                                                              .fontStyle,
                                                    ),
                                                    color:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineMedium
                                                            .fontStyle,
                                                    lineHeight: 1.25,
                                                  ),
                                            ),
                                            ),
                                            FlutterFlowIconButton(
                                              borderRadius: 8,
                                              buttonSize: 40,
                                              fillColor: Colors.transparent,
                                              icon: Icon(
                                                Icons.share_rounded,
                                                color:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                size: 24,
                                              ),
                                              onPressed: () {
                                                print(
                                                    'Share button pressed ...');
                                              },
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Personal Belongings • ID Cards',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .primary,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 4)),
                                    ),
                                    Divider(
                                      height: 16,
                                      thickness: 1,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          columnItemsRecord.description,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                font: GoogleFonts
                                                    .plusJakartaSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .titleMedium
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                        Text(
                                          columnItemsRecord.description.isNotEmpty
                                                  ? columnItemsRecord.description
                                                  : 'No additional details provided.',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .secondaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 8)),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFB5B5B5),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.add_location_alt_rounded,
                                              color: FlutterFlowTheme.of(
                                                      context)
                                                  .primaryText,
                                              size: 24,
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                columnItemsRecord.location,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFD7D6D6),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              color: FlutterFlowTheme.of(
                                                      context)
                                                  .primaryText,
                                              size: 24,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              valueOrDefault<String>(
                                                columnItemsRecord.createdAt
                                                    ?.toString(),
                                                'Date',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFC5C5C5),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: FlutterFlowTheme.of(
                                                      context)
                                                  .primaryText,
                                              size: 24,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              valueOrDefault<String>(
                                                columnItemsRecord.contactInfo,
                                                'No contact info',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        height: 180,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 24)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // FIXED: bottom buttons now use _contactInfo (state variable)
            // instead of columnItemsRecord which is out of scope here
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: Container(
                height: 88,
                decoration: BoxDecoration(
                  color:
                      FlutterFlowTheme.of(context).secondaryBackground,
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
                      ),
                    ),
                    Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                      child: SizedBox(
                        height: 56,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  // FIXED: uses _contactInfo state variable
                                  if (_contactInfo.isNotEmpty) {
                                    await launchURL('tel:$_contactInfo');
                                  }
                                },
                                child: wrapWithModel(
                                  model: _model.buttonModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ButtonWidget(
                                    content: 'Call Owner',
                                    icon: Icon(
                                      Icons.call_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 16,
                                    ),
                                    iconPresent: true,
                                    iconEndPresent: false,
                                    variant: 'outline',
                                    size: 'large',
                                    fullWidth: false,
                                    loading: false,
                                    disabled: false,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  // FIXED: uses _contactInfo state variable
                                  if (_contactInfo.isNotEmpty) {
                                    await launchURL(
                                        'https://wa.me/$_contactInfo');
                                  }
                                },
                                child: wrapWithModel(
                                  model: _model.buttonModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ButtonWidget(
                                    content: 'Send Message',
                                    icon: Icon(
                                      Icons.chat_bubble_outline_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).onPrimary,
                                      size: 16,
                                    ),
                                    iconPresent: true,
                                    iconEndPresent: false,
                                    variant: 'primary',
                                    size: 'large',
                                    fullWidth: false,
                                    loading: false,
                                    disabled: false,
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 16)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}