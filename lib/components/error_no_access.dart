import 'package:auto_route/auto_route.dart';
import 'package:brunstadtv_app/providers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/btv_buttons.dart';
import '../helpers/btv_colors.dart';
import '../helpers/btv_typography.dart';
import '../l10n/app_localizations.dart';

class ErrorNoAccess extends ConsumerWidget {
  const ErrorNoAccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        S.of(context).oops,
                        style: BtvTextStyles.headline2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        ref.read(authStateProvider).guestMode ? S.of(context).mustBeLoggedIn : S.of(context).dontHaveAccess,
                        textAlign: TextAlign.center,
                        style: BtvTextStyles.body1.copyWith(color: BtvColors.onTint),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(S.of(context).plentyOfOtherContent, textAlign: TextAlign.center, style: BtvTextStyles.body1.copyWith(color: BtvColors.onTint)),
                  Container(
                    padding: EdgeInsets.only(top: 24, bottom: 28),
                    width: double.infinity,
                    child: BtvButton.large(
                      labelText: S.of(context).exploreContent,
                      onPressed: () {
                        context.router.pop();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
