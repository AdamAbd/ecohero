import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../feature/feature.dart';

class PageRouter {
  Route<dynamic>? getRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      //* Splash
      case PagePath.splash:
        {
          return _buildRouter(
            settings: settings,
            builder: (Object? args) => const SplashPage(),
          );
        }

      //* Login
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
      case PagePath.challengeCategory:
        {
          return _buildRouter(
            settings: settings,
            builder: (Object? args) => const ChallengeCategoryPage(),
          );
        }
      case PagePath.challengeCategoryDetail:
        {
          return _buildRouter(
            settings: settings,
            builder: (Object? args) => ChallengeCategoryDetailPage(
              args: args! as ChallengeCategoryDetailPageArgs,
            ),
          );
        }
      case PagePath.challengeCreate:
        {
          return _buildRouter(
            settings: settings,
            builder: (Object? args) => ChallengeCreatePage(
              args: args! as ChallengeCreatePageArgs,
            ),
          );
        }
      case PagePath.challengeDetail:
        {
          return _buildRouter(
            settings: settings,
            builder: (Object? args) => ChallengeDetailPage(
              args: args! as ChallengeDetailPageArgs,
            ),
          );
        }

      //* Shop
      case PagePath.shop:
        {
          return _buildRouter(
            settings: settings,
            builder: (Object? args) => const ShopPage(),
          );
        }

      default:
        return _buildRouter(
          settings: settings,
          builder: (Object? args) => const SplashPage(),
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
