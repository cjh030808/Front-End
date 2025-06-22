import 'package:go_router/go_router.dart';
import 'package:zeroro/presentation/main/main_screen.dart';
import 'package:zeroro/presentation/routes/route_path.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.main,
      name: 'main',
      builder: (context, state) => MainScreen(),
    ),
  ],
  initialLocation: RoutePath.main,
);
