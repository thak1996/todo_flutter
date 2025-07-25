import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'home.controller.dart';
import 'home.state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => HomeController()..loadUser(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<HomeController>().logout();
                context.go('/login');
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

  Widget _buildUserContent(UserModel user, TextTheme theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Bem-vindo, ${user.name ?? "Usuário"}!', style: theme.bodyLarge),
      ],
    );
  }

  Widget _buildErrorMessage(String message, TextTheme theme) {
    return Text(message, style: theme.bodyLarge?.copyWith(color: Colors.red));
  }
}
