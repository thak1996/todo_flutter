import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/app/core/models/auth/user.model.dart';
import '../../core/theme/theme_switch.dart';
import 'home.controller.dart';
import 'home.state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => HomeController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<HomeController>().logout();
                context.go('/');
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<HomeController, HomeState>(
              builder: (context, state) {
                final stateWidgets = {
                  HomeInitial: () => const CircularProgressIndicator(),
                  HomeLoaded: () {
                    final loadedState = state as HomeLoaded;
                    return _buildUserContent(loadedState.user, theme);
                  },
                  HomeError: () {
                    final errorState = state as HomeError;
                    return _buildErrorMessage(errorState.message, theme);
                  },
                };
                return stateWidgets[state.runtimeType]?.call() ??
                    const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserContent(UserModel user, ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Bem-vindo, ${user.email ?? "Usuário"}!',
          style: theme.textTheme.displayLarge,
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode', style: theme.textTheme.titleLarge),
                const ThemeSwitch(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String message, ThemeData theme) {
    return Text(
      message,
      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
    );
  }
}
