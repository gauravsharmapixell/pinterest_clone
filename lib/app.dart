import 'package:clerk_flutter/generated/clerk_sdk_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class PinterestCloneApp extends ConsumerWidget {
  const PinterestCloneApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Pinterest Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
      localizationsDelegates: ClerkSdkLocalizations.localizationsDelegates,
      supportedLocales: ClerkSdkLocalizations.supportedLocales,
    );
  }
}
