import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mined_2025/client/pages/auth_page/login_page.dart';
import 'package:mined_2025/client/pages/auth_page/register_page.dart';
import 'package:mined_2025/client/pages/landing_page/main_layout.dart';
import '../pages/landing_page/landing_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _noAnimationPage(
         MainLayout(child: LandingPage()),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => _noAnimationPage(
        const MainLayout(child: LoginPage()),
      ),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => _noAnimationPage(
        const MainLayout(child: RegisterPage()),
      ),
    ),
  ],
);

Page<void> _noAnimationPage(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    transitionDuration: Duration.zero,
  );
}
