import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/app/page/auth/login/login.page.dart';
import 'package:todo_flutter/app/page/auth/register/register.page.dart';
import 'package:todo_flutter/app/page/auth/splash/splash.page.dart';
import 'package:todo_flutter/app/page/home/home.page.dart';
import 'auth.notifier.dart';

final authNotifier = AuthNotifier();

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: authNotifier,
  redirect: _redirectHandler,
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
  ],
);

String? _redirectHandler(BuildContext context, GoRouterState state) {
  final isAuthenticated = authNotifier.isAuthenticated;
  final location = state.uri.path;

  final publicRoutes = ['/login', '/register'];
  if (location == '/') return null;

  if (!isAuthenticated && !publicRoutes.contains(location)) return '/login';
  if (isAuthenticated && publicRoutes.contains(location)) return '/home';

  return null;
}
