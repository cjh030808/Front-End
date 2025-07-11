import 'package:go_router/go_router.dart';
import 'package:zeroro/presentation/screens/main/main_screen.dart';
import 'package:zeroro/presentation/routes/route_path.dart';

import '../../domain/model/post/post.model.dart';
import '../screens/entry/login_screen.dart';
import '../screens/entry/splash_screen.dart';
import '../screens/post/edit_post_screen.dart';
import '../screens/post/new_post_screen.dart';

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
    GoRoute(
      path: RoutePath.newPost,
      name: 'newPost',
      builder: (context, state) => NewPostScreen(),
    ),
    GoRoute(
      path: RoutePath.editPost,
      name: 'editPost',
      builder: (context, state) => EditPostScreen(post: state.extra as Post),
    ),
  ],

  initialLocation: RoutePath.splash,
);
