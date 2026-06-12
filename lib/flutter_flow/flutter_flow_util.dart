import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';
import 'package:text_search/text_search.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import 'nav/serialization_util.dart';

export 'lat_lng.dart';
export 'nav/serialization_util.dart' show serializeParam, ParamType;
export 'nav/nav.dart' show GoRouter;
export 'package:collection/collection.dart' show IterableExtension;
export 'package:text_search/text_search.dart'
    show TextSearch, TextSearchItem, fuzzySearch;

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

DateTime get getCurrentTimestamp => DateTime.now();

String dateTimeFormat(String format, DateTime dateTime) {
  if (format == 'relative') {
    return timeago.format(dateTime);
  }
  return DateFormat(format).format(dateTime);
}

DateTime dateTimeFromSecondsSinceEpoch(int seconds) {
  return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
}

extension DateTimeConversionExtension on DateTime {
  int get secondsSinceEpoch => millisecondsSinceEpoch ~/ 1000;
}

extension DateTimeComparisonOperators on DateTime {
  bool operator <(DateTime other) => isBefore(other);
  bool operator >(DateTime other) => isAfter(other);
  bool operator <=(DateTime other) => this < other || isAtSameMomentAs(other);
  bool operator >=(DateTime other) => this > other || isAtSameMomentAs(other);
}

T? castToType<T>(dynamic value) {
  if (value == null) {
    return null;
  }
  switch (T) {
    case double:
      return value.toDouble() as T;
    case int:
      return value.round() as T;
    case String:
      return value.toString() as T;
    default:
      return value as T;
  }
}

void safeSetState(VoidCallback fn) {
  fn();
}

extension StatefulWidgetExtensions on State {
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}

extension ListDivideExt<T extends Widget> on Iterable<T> {
  Iterable<MapEntry<int, Widget>> get enumerate => toList().asMap().entries;

  List<Widget> divide(Widget t, {bool Function(int)? filterFn}) => isEmpty
      ? []
      : (enumerate
          .map((e) => [e.value, if (filterFn == null || filterFn(e.key)) t])
          .expand((i) => i)
          .toList()
        ..removeLast());

  List<Widget> around(Widget t) => addToStart(t).addToEnd(t);

  List<Widget> addToStart(Widget t) =>
      enumerate.map((e) => e.value).toList()..insert(0, t);

  List<Widget> addToEnd(Widget t) =>
      enumerate.map((e) => e.value).toList()..add(t);

  List<Padding> paddingTopEach(double val) =>
      map((w) => Padding(padding: EdgeInsets.only(top: val), child: w))
          .toList();
}

extension ListFilterExt<T> on Iterable<T?> {
  Iterable<T> get withoutNulls => where((s) => s != null).map((e) => e!);
}

extension MapFilterExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

Future launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

abstract class FlutterFlowModel<T extends StatefulWidget> {
  bool _isInitialized = false;
  bool _isDisposed = false;

  void initState(BuildContext context);

  void _init(BuildContext context) {
    if (!_isInitialized) {
      initState(context);
      _isInitialized = true;
    }
  }

  void dispose() {}

  VoidCallback onUpdate = () {};

  void maybeDispose() {
    if (!_isDisposed) {
      dispose();
      _isDisposed = true;
    }
  }
}

T createModel<T extends FlutterFlowModel>(
  BuildContext context,
  T Function() defaultBuilder,
) {
  final model = defaultBuilder();
  model._init(context);
  return model;
}

Widget wrapWithModel<T extends FlutterFlowModel>({
  required T model,
  required Widget child,
  required VoidCallback updateCallback,
  bool updateOnChange = false,
}) {
  model.onUpdate = updateCallback;
  return child;
}

class FlutterFlowDynamicModels<T extends FlutterFlowModel> {
  FlutterFlowDynamicModels(this.defaultBuilder);

  final T Function() defaultBuilder;
  final Map<String, T> _childrenModels = {};

  T getModel(String uniqueKey, int index) {
    final key = '$uniqueKey-$index';
    return _childrenModels[key] ??= defaultBuilder();
  }

  void dispose() {
    for (final model in _childrenModels.values) {
      model.dispose();
    }
    _childrenModels.clear();
  }
}

extension BuildContextExtensions on BuildContext {
  void pushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
  }) =>
      GoRouter.of(this).pushNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
  }) =>
      GoRouter.of(this).goNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
  }) {
    if (!mounted) {
      return;
    }
    pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void safePop() {
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  void prepareAuthEvent() {}
}

String getCurrentRoute(BuildContext context) =>
    GoRouterState.of(context).uri.toString();

bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isiOS => !kIsWeb && Platform.isIOS;
bool get isWeb => kIsWeb;

extension FFValidatorExtension
    on String? Function(BuildContext, String?)? {
  String? Function(String?) asValidator(BuildContext context) =>
      (val) => this != null ? this!(context, val) : null;
}
