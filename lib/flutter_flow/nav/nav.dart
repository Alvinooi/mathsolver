import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
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
          appStateNotifier.loggedIn ? const NavBarPage() : const OnboardingWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? const NavBarPage() : const OnboardingWidget(),
        ),
        FFRoute(
          name: 'Home',
          path: '/home',
          builder: (context, params) =>
              params.isEmpty ? const NavBarPage(initialPage: 'Home') : const HomeWidget(),
        ),
        FFRoute(
          name: 'SignUp',
          path: '/signUp',
          builder: (context, params) => const SignUpWidget(),
        ),
        FFRoute(
          name: 'Chat',
          path: '/chat',
          requireAuth: true,
          asyncParams: {
            'messagesList': getDocList(['message'], MessageRecord.fromSnapshot),
          },
          builder: (context, params) => ChatWidget(
            chat: params.getParam(
              'chat',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['chat'],
            ),
            messagesList: params.getParam<MessageRecord>(
              'messagesList',
              ParamType.Document,
              isList: true,
            ),
            home: params.getParam(
              'home',
              ParamType.bool,
            ),
            url: params.getParam(
              'url',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'Profile',
          path: '/profile',
          builder: (context, params) => const ProfileWidget(),
        ),
        FFRoute(
          name: 'Login',
          path: '/login',
          builder: (context, params) => const LoginWidget(),
        ),
        FFRoute(
          name: 'Onboarding',
          path: '/onboarding',
          builder: (context, params) => const OnboardingWidget(),
        ),
        FFRoute(
          name: 'ForgotPassword',
          path: '/forgotPassword',
          builder: (context, params) => const ForgotPasswordWidget(),
        ),
        FFRoute(
          name: 'ListChat',
          path: '/listChat',
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'ListChat')
              : const ListChatWidget(),
        ),
        FFRoute(
          name: 'Calculator',
          path: '/calculator',
          asyncParams: {
            'history': getDoc(['calculation'], CalculationRecord.fromSnapshot),
          },
          builder: (context, params) => CalculatorWidget(
            history: params.getParam(
              'history',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'VisualiseGraph1',
          path: '/visualiseGraph1',
          asyncParams: {
            'graph': getDoc(['graph'], GraphRecord.fromSnapshot),
          },
          builder: (context, params) => VisualiseGraph1Widget(
            xInput: params.getParam(
              'xInput',
              ParamType.String,
            ),
            graphType: params.getParam(
              'graphType',
              ParamType.String,
            ),
            yInput: params.getParam(
              'yInput',
              ParamType.String,
            ),
            graph: params.getParam(
              'graph',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'CreateGraph1',
          path: '/createGraph1',
          builder: (context, params) => const NavBarPage(
            initialPage: '',
            page: CreateGraph1Widget(),
          ),
        ),
        FFRoute(
          name: 'CreateGraph3a',
          path: '/createGraph3a',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: CreateGraph3aWidget(
              graphType: params.getParam(
                'graphType',
                ParamType.String,
              ),
            ),
          ),
        ),
        FFRoute(
          name: 'CreateGraph3b',
          path: '/createGraph3b',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: CreateGraph3bWidget(
              graphType: params.getParam(
                'graphType',
                ParamType.String,
              ),
            ),
          ),
        ),
        FFRoute(
          name: 'Graph3c',
          path: '/graph3c',
          builder: (context, params) => Graph3cWidget(
            graphType: params.getParam(
              'graphType',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'ListGraph',
          path: '/listGraph',
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'ListGraph')
              : const ListGraphWidget(),
        ),
        FFRoute(
          name: 'ListCalculation',
          path: '/listCalculation',
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'ListCalculation')
              : const ListCalculationWidget(),
        ),
        FFRoute(
          name: 'Settings',
          path: '/settings',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Settings')
              : const SettingsWidget(),
        ),
        FFRoute(
          name: 'NotificationsSetting',
          path: '/notificationsSetting',
          builder: (context, params) => const NotificationsSettingWidget(),
        ),
        FFRoute(
          name: 'SecuritySetting',
          path: '/securitySetting',
          builder: (context, params) => const SecuritySettingWidget(),
        ),
        FFRoute(
          name: 'ResetPassword',
          path: '/resetPassword',
          builder: (context, params) => ResetPasswordWidget(
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'ChangePassword',
          path: '/changePassword',
          builder: (context, params) => ChangePasswordWidget(
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'AppearanceSetting',
          path: '/appearanceSetting',
          builder: (context, params) => const AppearanceSettingWidget(),
        ),
        FFRoute(
          name: 'ListGroup',
          path: '/listGroup',
          requireAuth: true,
          builder: (context, params) => const NavBarPage(
            initialPage: '',
            page: ListGroupWidget(),
          ),
        ),
        FFRoute(
          name: 'OtherProfile',
          path: '/otherProfile',
          asyncParams: {
            'user': getDoc(['user'], UserRecord.fromSnapshot),
          },
          builder: (context, params) => OtherProfileWidget(
            user: params.getParam(
              'user',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'Group',
          path: '/group',
          builder: (context, params) => GroupWidget(
            group: params.getParam(
              'group',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['chatGroup'],
            ),
          ),
        ),
        FFRoute(
          name: 'ChatMember',
          path: '/chatMember',
          asyncParams: {
            'chat': getDoc(['chat'], ChatRecord.fromSnapshot),
          },
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: ChatMemberWidget(
              chat: params.getParam(
                'chat',
                ParamType.Document,
              ),
            ),
          ),
        ),
        FFRoute(
          name: 'GraphCustomisation',
          path: '/graphCustomisation',
          builder: (context, params) => GraphCustomisationWidget(
            graphType: params.getParam(
              'graphType',
              ParamType.String,
            ),
            updateGraph: params.getParam(
              'updateGraph',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: 'ScanSolve',
          path: '/scanSolve',
          builder: (context, params) => const ScanSolveWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
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
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
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
            return '/onboarding';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Screenshot_2024-11-26_203956-removebg-preview.png',
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
