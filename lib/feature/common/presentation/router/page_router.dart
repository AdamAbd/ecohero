import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../feature/feature.dart';

class PageRouter {
  Route<dynamic>? getRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      //* Onboarding
      case PagePath.login:
        {
          return _buildRouter(
            settings: settings,
            builder: (Object? args) => const LoginPage(),
          );
        }

      //* Home
      case PagePath.home:
        {
          return _buildRouter(
            settings: settings,
            builder: (Object? args) => const HomePage(),
          );
        }

      //* Challenge
      case PagePath.challenge:
        {
          return _buildRouter(
            settings: settings,
            builder: (Object? args) => ChallengePage(
              args: args! as ChallengePageArgs,
            ),
          );
        }

      default:
        return _buildRouter(
          settings: settings,
          builder: (Object? args) => const LoginPage(),
        );
    }
  }

  Route<dynamic> _buildRouter({
    required RouteSettings settings,
    required Widget Function(Object? arguments) builder,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          builder(settings.arguments),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
