import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/auth/base_auth_user_provider.dart';
import '/index.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart' show GoRoute, GoRouter;

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn
              ? const DashboardScreenWidget()
              : const WelcomeScreenWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn
                  ? const DashboardScreenWidget()
                  : const SplashScreenWidget(),
        ),
        FFRoute(
          name: SplashScreenWidget.routeName,
          path: SplashScreenWidget.routePath,
          builder: (context, params) => const SplashScreenWidget(),
        ),
        FFRoute(
          name: WelcomeScreenWidget.routeName,
          path: WelcomeScreenWidget.routePath,
          builder: (context, params) => const WelcomeScreenWidget(),
        ),
        FFRoute(
          name: LoginScreenWidget.routeName,
          path: LoginScreenWidget.routePath,
          builder: (context, params) => const LoginScreenWidget(),
        ),
        FFRoute(
          name: SignupScreenWidget.routeName,
          path: SignupScreenWidget.routePath,
          builder: (context, params) => const SignupScreenWidget(),
        ),
        FFRoute(
          name: DashboardScreenWidget.routeName,
          path: DashboardScreenWidget.routePath,
          requireAuth: true,
          builder: (context, params) => const DashboardScreenWidget(),
        ),
        FFRoute(
          name: LostItemsFeedWidget.routeName,
          path: LostItemsFeedWidget.routePath,
          builder: (context, params) => const LostItemsFeedWidget(),
        ),
        FFRoute(
          name: FoundItemsFeedWidget.routeName,
          path: FoundItemsFeedWidget.routePath,
          builder: (context, params) => const FoundItemsFeedWidget(),
        ),
        FFRoute(
          name: ItemDetailWidget.routeName,
          path: ItemDetailWidget.routePath,
          builder: (context, params) => ItemDetailWidget(
            itemRef: params.getParam(
              'itemRef',
              ParamType.DocumentReference,
              false,
              collectionNamePath: ['items'],
            ),
          ),
        ),
        FFRoute(
          name: ReportItemWidget.routeName,
          path: ReportItemWidget.routePath,
          builder: (context, params) => ReportItemWidget(
            editItem: params.getParam(
              'editItem',
              ParamType.DocumentReference,
              false,
              collectionNamePath: ['items'],
            ),
            initialType: params.getParam(
              'type',
              ParamType.String,
              false,
            ),
          ),
        ),
        FFRoute(
          name: ProfileMyPostsWidget.routeName,
          path: ProfileMyPostsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => const ProfileMyPostsWidget(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> get allParams => state.allParams;

  dynamic getParam<T>(
    String paramName,
    ParamType paramType,
    bool isList, {
    List<String>? collectionNamePath,
  }) {
    if (asyncParams.containsKey(paramName)) {
      return asyncParams[paramName]!(state.allParams[paramName] as String);
    }
    return deserializeParam<T>(
      state.allParams[paramName] as String?,
      paramType,
      isList,
      collectionNamePath: collectionNamePath,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return WelcomeScreenWidget.routePath;
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              : page;

          return MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

void fixStatusBarOniOS16AndBelow(BuildContext context) {
  // No-op for Android-focused build.
}
