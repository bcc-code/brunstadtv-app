import 'package:auto_route/auto_route.dart';
import 'package:bccm_core/bccm_core.dart';
import 'package:brunstadtv_app/providers/settings.dart';
import 'package:brunstadtv_app/helpers/share_image.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainJsChannel {
  final ProviderContainer ref;
  final StackRouter router;
  final bool enableAuth;
  const MainJsChannel._({required this.router, required this.ref, required this.enableAuth});

  static void register(BuildContext context, InAppWebViewController controller, {required bool enableAuth}) {
    final ref = ProviderScope.containerOf(context, listen: false);
    final channel = MainJsChannel._(router: context.router, ref: ref, enableAuth: enableAuth);
    controller.addJavaScriptHandler(
      handlerName: 'flutter_main',
      callback: channel.handleMessage,
    );
  }

  Object? handleMessage(List<dynamic> arguments) {
    if (arguments[0] == 'navigate') {
      return _navigate(arguments);
    } else if (arguments[0] == 'push') {
      return _push(arguments);
    } else if (arguments[0] == 'exit') {
      return _exit(arguments);
    } else if (arguments[0] == 'get_access_token' && enableAuth) {
      return _getAccessToken(arguments);
    } else if (arguments[0] == 'get_locale') {
      return _getLocale(arguments);
    } else if (arguments[0] == 'share_image') {
      return _shareImage(arguments);
    } else if (arguments[0] == 'haptic_feedback') {
      return _hapticFeedback(arguments);
    }
    return null;
  }

  Future _navigate(List<dynamic> arguments) {
    if (arguments[1] is String) {
      return router.navigateNamedFromRoot(arguments[1]);
    }
    throw Exception('Tried to navigate with invalid argument: ${arguments[1]}');
  }

  Future _push(List<dynamic> arguments) async {
    if (arguments[1] is String) {
      return router.pushNamed(arguments[1], includePrefixMatches: true);
    }
    throw Exception('Tried to push with invalid argument: ${arguments[1]}');
  }

  Future _exit(List<dynamic> arguments) async {
    return router.pop();
  }

  String? _getAccessToken(List<dynamic> arguments) {
    debugPrint('delivering access token to js');
    return ref.read(authStateProvider).auth0AccessToken;
  }

  String _getLocale(List arguments) {
    return ref.read(settingsProvider).appLanguage.languageCode;
  }

  Future _hapticFeedback(List<dynamic> arguments) {
    if (arguments[1] is! String) {
      throw Exception('hapticFeedback: first argument isnt string: ${arguments[1]}');
    }

    final type = arguments[1] as String;
    switch (type) {
      case 'vibrate':
        return CustomHapticFeedback.vibrate();
      case 'lightImpact':
        return CustomHapticFeedback.lightImpact();
      case 'mediumImpact':
        return CustomHapticFeedback.mediumImpact();
      case 'heavyImpact':
        return CustomHapticFeedback.heavyImpact();
      case 'selectionClick':
        return CustomHapticFeedback.selectionClick();
    }

    throw Exception('hapticFeedback: invalid argument ${arguments[1]}');
  }

  Future<bool> _shareImage(List<dynamic> arguments) async {
    if (arguments[1] is String) {
      final context = router.navigatorKey.currentState?.context;
      if (context == null) {
        FirebaseCrashlytics.instance.recordError(Exception('shareImage: context is null'), StackTrace.current);
        return false;
      }
      await downloadAndShareImage(arguments[1], sharePositionOrigin: iPadSharePositionOrigin(context));
      return true;
    }
    FirebaseCrashlytics.instance.recordError(Exception('shareImage: Invalid argument: ${arguments[1]}'), StackTrace.current);
    return false;
  }
}
