import 'package:go_router/go_router.dart';
import 'page/auth/login/login.page.dart';
import 'page/auth/splash/splash.page.dart';
import 'page/home/home.page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
  ],
);
