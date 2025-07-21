import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';
import 'app.provider.dart';
import 'app.router.dart';
import 'core/theme/app.theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.providers,
      child: MaterialApp.router(
        onGenerateTitle: (ctx) => AppLocalizations.of(ctx).titleApp,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
