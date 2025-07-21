import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/app/core/models/auth/user.model.dart';
import '../../../l10n/app_localizations.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 2));
    final isValid = await UserModel.areSavedDataValid();
    if (!mounted) return;
    if (isValid) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(l10n.titleApp, style: theme.titleLarge)],
        ),
      ),
    );
  }
}
