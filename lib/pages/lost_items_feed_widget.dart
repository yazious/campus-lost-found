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
                                                record.itemId!,
                                                record.title!,
                                                record.type!,
                                                record.category!,
                                                record.location!,
                                                record.status!,
                                                record.description!,
                                                record.postedBy!,
                                                record.postedByName!
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

                    return SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(columnItemsRecordList.length,
                            (columnIndex) {
                          final columnItemsRecord =
                              columnItemsRecordList[columnIndex];
                          return Padding(
                            padding: EdgeInsets.all(24),
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.selectedCategory = 'all';
                                            safeSetState(() {});
                                          },
                                          child: CategoryChipWidget(
                                            key: Key(
                                                'Key328_${columnIndex}_of_${columnItemsRecordList.length}'),
                                            icon: Icon(
                                              Icons.grid_view_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .onPrimary,
                                              size: 18,
                                            ),
                                            label: 'All',
                                            selected: true,
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.selectedCategory =
                                                'Electronics';
                                            safeSetState(() {});
                                          },
                                          child: CategoryChipWidget(
                                            key: Key(
                                                'Key329_${columnIndex}_of_${columnItemsRecordList.length}'),
                                            icon: Icon(
                                              Icons.devices_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 18,
                                            ),
                                            label: 'Electronics',
                                            selected: false,
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.selectedCategory =
                                                'Documents';
                                            safeSetState(() {});
                                          },
                                          child: CategoryChipWidget(
                                            key: Key(
                                                'Key330_${columnIndex}_of_${columnItemsRecordList.length}'),
                                            icon: Icon(
                                              Icons.description_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 18,
                                            ),
                                            label: 'Documents',
                                            selected: false,
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.selectedCategory =
                                                'Personal';
                                            safeSetState(() {});
                                          },
                                          child: CategoryChipWidget(
                                            key: Key(
                                                'Key331_${columnIndex}_of_${columnItemsRecordList.length}'),
                                            icon: Icon(
                                              Icons.person_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 18,
                                            ),
                                            label: 'Personal',
                                            selected: false,
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8)),
                                    ),
                                  ),
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
                                      date: '2 hours ago',
                                      description:
                                          'Contains a Dell charger and a blue notebook. Left near the study cubicles.',
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/black%20backpack%20on%20a%20chair',
                                      initials: 'AK',
                                      location: 'Library Basement',
                                      title: 'Black Laptop Bag',
                                      user: 'Ahmed Khan',
                                      itemRef: columnItemsRecord.reference,
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.lostItemCardModels2.getModel(
                                      columnItemsRecord.itemId,
                                      columnIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: LostItemCardWidget(
                                      key: Key(
                                        'Key369_${columnItemsRecord.itemId}',
                                      ),
                                      date: 'Today, 10:15 AM',
                                      description:
                                          'Blue color, transparent case. Has a sticker of a cat on the back.',
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/smartphone%20on%20a%20table',
                                      initials: 'SA',
                                      location: 'Cafe Area',
                                      title: 'iPhone 13 Pro',
                                      user: 'Sara Ali',
                                      itemRef: columnItemsRecord.reference,
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.lostItemCardModels3.getModel(
                                      columnItemsRecord.itemId,
                                      columnIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: LostItemCardWidget(
                                      key: Key(
                                        'Key370_${columnItemsRecord.itemId}',
                                      ),
                                      date: 'Yesterday',
                                      description:
                                          'ID card for Department of CS. Name: Zayn Malik, Roll No: 12345.',
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/plastic%20identification%20card',
                                      initials: 'ZM',
                                      location: 'Admin Block',
                                      title: 'Student ID Card',
                                      user: 'Zayn Malik',
                                      itemRef: columnItemsRecord.reference,
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.lostItemCardModels4.getModel(
                                      columnItemsRecord.itemId,
                                      columnIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: LostItemCardWidget(
                                      key: Key(
                                        'Key371_${columnItemsRecord.itemId}',
                                      ),
                                      date: 'Oct 24',
                                      description:
                                          'Casio fx-991EX. Name written on the back with a permanent marker.',
                                      imgDesc:
                                          'https://dimg.dreamflow.cloud/v1/image/casio%20calculator',
                                      initials: 'BJ',
                                      location: 'Physics Lab',
                                      title: 'Scientific Calculator',
                                      user: 'Bilal J.',
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
                              Column(
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
                              Column(
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
                              Column(
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
                              Column(
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
                              Column(
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
