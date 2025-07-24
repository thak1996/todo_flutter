import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import 'splash.controller.dart';
import 'splash.state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => SplashController()..checkUserAuthentication(),
      child: BlocListener<SplashController, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) context.go('/home');
          if (state is SplashUnauthenticated) context.go('/login');
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(l10n.titleApp, style: theme.titleLarge),
                const SizedBox(height: 20),
                BlocBuilder<SplashController, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoading ||
                        state is SplashAuthenticated ||
                        state is SplashUnauthenticated) {
                      return const CircularProgressIndicator();
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
