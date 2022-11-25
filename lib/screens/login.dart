import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:brunstadtv_app/helpers/btv_typography.dart';
import 'package:brunstadtv_app/providers/auth_state.dart';
import 'package:brunstadtv_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/btv_buttons.dart';
import '../helpers/btv_colors.dart';
import '../l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String? loginError;
  final void Function(bool)? onResult;

  const LoginScreen({super.key, this.loginError, this.onResult});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isProgressing = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  bool imagesLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200)).then(
      (_) => setState(() => imagesLoaded = true),
    );
  }

  handleSuccess() {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
    });
    if (widget.onResult != null) {
      widget.onResult!(true);
    }

    context.router.popUntil((route) => false);
    context.router.pushNamed('/');
  }

  handleError(String message) {
    setState(() {
      isProgressing = false;
      errorMessage = message;
    });
  }

  Future<void> loginAction() async {
    final tryAgainMessage = S.of(context).errorTryAgain;
    setState(() {
      isProgressing = true;
      errorMessage = '';
    });

    final success = await ref.read(authStateProvider.notifier).login();
    if (success) {
      handleSuccess();
    } else {
      handleError(tryAgainMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        shadowColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png'),
        automaticallyImplyLeading: false,
      ),
      body: AnimatedOpacity(
        opacity: imagesLoaded ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 220,
                    margin: const EdgeInsets.only(bottom: 32),
                    child: Image.asset('assets/images/Onboarding.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 38, bottom: 12, left: 38),
                    child: Text(
                      S.of(context).loginPageDisplay1,
                      style: BtvTextStyles.title1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 38, bottom: 60, right: 38),
                    child: Text(
                      S.of(context).loginPageDisplay2,
                      textAlign: TextAlign.center,
                      style: BtvTextStyles.body1.copyWith(color: BtvColors.label3),
                    ),
                  ),
                  Text(
                    S.of(context).loginPageDisplay3,
                    style: BtvTextStyles.caption1.copyWith(color: BtvColors.label3),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: max(16, MediaQuery.of(context).padding.bottom)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (errorMessage != '') Padding(padding: const EdgeInsets.only(bottom: 16), child: Text(errorMessage, textAlign: TextAlign.center)),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: BtvButton.large(
                      onPressed: loginAction,
                      labelText: S.of(context).signInButton,
                    ),
                  ),
                  BtvButton.mediumSecondary(
                    labelText: S.of(context).skipToPublicContent,
                    onPressed: () {
                      context.router.popUntil((route) => false);
                      context.router.push(const TabsRootScreenRoute());
                    },
                  ).copyWith(
                    backgroundColor: Colors.transparent,
                    border: Border.all(color: Colors.transparent),
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
