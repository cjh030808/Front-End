import 'package:go_router/go_router.dart';
import 'package:zeroro/presentation/main/main_screen.dart';
import 'package:zeroro/presentation/routes/route_path.dart';

import '../entry/login_screen.dart';
import '../entry/splash_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.main,
      name: 'main',
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      path: RoutePath.splash,
      name: 'splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: RoutePath.login,
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
  ],
  
  initialLocation: RoutePath.splash,
);
