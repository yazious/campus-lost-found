import '/backend/backend.dart';
import '/components/category_chip/category_chip_widget.dart';
import '/components/lost_item_card/lost_item_card_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

import 'lost_items_feed_model.dart';
export 'lost_items_feed_model.dart';

class LostItemsFeedWidget extends StatefulWidget {
  const LostItemsFeedWidget({super.key});

  static String routeName = 'LostItemsFeed';
  static String routePath = '/lostItemsFeed';

  @override
  State<LostItemsFeedWidget> createState() => _LostItemsFeedWidgetState();
}

class _LostItemsFeedWidgetState extends State<LostItemsFeedWidget> {
  late LostItemsFeedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LostItemsFeedModel());
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
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 24),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                      ),
                      Row(
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
                            'Lost Items',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                  lineHeight: 1.3,
                                ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.notifications_none_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await queryItemsRecordOnce()
                                    .then(
                                      (records) => _model.simpleSearchResults =
                                          TextSearch(
                                        records
                                            .map(
                                              (record) =>
                                                  TextSearchItem.fromTerms(
                                                      record, [
                                                record.itemId,
                                                record.title,
                                                record.type,
                                                record.category,
                                                record.location,
                                                record.status,
                                                record.description,
                                                record.postedBy,
                                                record.postedByName,
                                              ]),
                                            )
                                            .toList(),
                                      )
                                              .search(_model.searchFieldModel
                                                  .inputTextController.text)
                                              .map((r) => r.object)
                                              .toList(),
                                    )
                                    .onError((_, __) =>
                                        _model.simpleSearchResults = [])
                                    .whenComplete(() => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.searchFieldModel,
                                updateCallback: () => safeSetState(() {}),
                                child: TextFieldWidget(
                                  model: _model.searchFieldModel,
                                  label: '',
                                  labelPresent: false,
                                  helper: '',
                                  helperPresent: false,
                                  hint: 'Search for keys, bags, wallets...',
                                  value: '',
                                  onChange: '',
                                  onSubmit: '',
                                  leadingIcon: Icon(
                                    Icons.search_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 16,
                                  ),
                                  leadingIconPresent: true,
                                  trailingIconPresent: false,
                                  variant: 'filled',
                                  error: false,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                              shape: BoxShape.rectangle,
                            ),
                            alignment: AlignmentDirectional(0, 0),
                            child: Icon(
                              Icons.tune_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .onPrimaryContainer,
                              size: 22,
                            ),
                          ),
                        ].divide(SizedBox(width: 16)),
                      ),
                    ].divide(SizedBox(height: 16)),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: StreamBuilder<List<ItemsRecord>>(
                  stream: queryItemsRecord(
                    queryBuilder: (itemsRecord) => itemsRecord
                        .where(
                          'type',
                          isEqualTo: 'lost',
                        )
                        .orderBy('createdAt', descending: true),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
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
                    List<ItemsRecord> columnItemsRecordList = snapshot.data!;
                    List<ItemsRecord> displayList =
                        _model.simpleSearchResults.isNotEmpty
                            ? _model.simpleSearchResults
                            : columnItemsRecordList;
                    if (_model.simpleSearchResults.isEmpty &&
                        _model.selectedCategory != 'all') {
                      displayList = displayList
                          .where((record) =>
                              record.category == _model.selectedCategory)
                          .toList();
                    }

                    return SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _model.selectedCategory = 'all';
                                      _model.simpleSearchResults = [];
                                      safeSetState(() {});
                                    },
                                    child: CategoryChipWidget(
                                      icon: Icon(Icons.grid_view_rounded,
                                          color: _model.selectedCategory ==
                                                  'all'
                                              ? FlutterFlowTheme.of(context)
                                                  .onPrimary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          size: 18),
                                      label: 'All',
                                      selected:
                                          _model.selectedCategory == 'all',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _model.selectedCategory = 'Electronics';
                                      _model.simpleSearchResults = [];
                                      safeSetState(() {});
                                    },
                                    child: CategoryChipWidget(
                                      icon: Icon(Icons.devices_rounded,
                                          color: _model.selectedCategory ==
                                                  'Electronics'
                                              ? FlutterFlowTheme.of(context)
                                                  .onPrimary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          size: 18),
                                      label: 'Electronics',
                                      selected: _model.selectedCategory ==
                                          'Electronics',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _model.selectedCategory = 'Documents';
                                      _model.simpleSearchResults = [];
                                      safeSetState(() {});
                                    },
                                    child: CategoryChipWidget(
                                      icon: Icon(Icons.description_rounded,
                                          color: _model.selectedCategory ==
                                                  'Documents'
                                              ? FlutterFlowTheme.of(context)
                                                  .onPrimary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          size: 18),
                                      label: 'Documents',
                                      selected: _model.selectedCategory ==
                                          'Documents',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _model.selectedCategory = 'Clothing';
                                      _model.simpleSearchResults = [];
                                      safeSetState(() {});
                                    },
                                    child: CategoryChipWidget(
                                      icon: Icon(Icons.person_rounded,
                                          color: _model.selectedCategory ==
                                                  'Clothing'
                                              ? FlutterFlowTheme.of(context)
                                                  .onPrimary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          size: 18),
                                      label: 'Personal',
                                      selected: _model.selectedCategory ==
                                          'Clothing',
                                    ),
                                  ),
                                ].divide(SizedBox(width: 8)),
                              ),
                            ),
                          ),
                          ...List.generate(displayList.length, (columnIndex) {
                          final columnItemsRecord =
                              displayList[columnIndex];
                          return Padding(
                            padding: EdgeInsets.all(24),
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  wrapWithModel(
                                    model: _model.lostItemCardModels1.getModel(
                                      columnItemsRecord.itemId,
                                      columnIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: LostItemCardWidget(
                                      key: Key(
                                        'Key368_${columnItemsRecord.itemId}',
                                      ),
                                      date: columnItemsRecord.createdAt != null
                                          ? dateTimeFormat(
                                              'relative',
                                              columnItemsRecord.createdAt!)
                                          : 'Recently',
                                      description:
                                          columnItemsRecord.description,
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/${Uri.encodeComponent(columnItemsRecord.title)}',
                                      initials: columnItemsRecord.postedByName
                                              .isNotEmpty
                                          ? columnItemsRecord.postedByName
                                              .substring(0, 2)
                                              .toUpperCase()
                                          : 'UN',
                                      location: columnItemsRecord.location,
                                      title: columnItemsRecord.title,
                                      user: columnItemsRecord.postedByName,
                                      itemRef: columnItemsRecord.reference,
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                  ),
                                ].divide(SizedBox(height: 16)),
                              ),
                            ),
                          );
                        }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: Container(
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
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      child: Container(
                        child: Container(
                          height: 79,
                          alignment: AlignmentDirectional(0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.home_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
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
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                      LostItemsFeedWidget.routeName);
                                },
                                child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24,
                                  ),
                                  Text(
                                    'Lost',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
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
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                      FoundItemsFeedWidget.routeName);
                                },
                                child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
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
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(ReportItemWidget.routeName);
                                },
                                child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius: BorderRadius.circular(9999),
                                      shape: BoxShape.rectangle,
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      size: 28,
                                    ),
                                  ),
                                ].divide(SizedBox(height: 4)),
                              ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                      ProfileMyPostsWidget.routeName);
                                },
                                child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person_outline_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
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
                            ],
                          ),
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