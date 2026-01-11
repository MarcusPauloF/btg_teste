import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/subscriptions/presentation/pages/subscription_detail_page.dart';
import '../../features/subscriptions/presentation/pages/subscription_list_page.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');

    if (uri.path == AppRoutes.login || uri.path == '/' || uri.path.isEmpty) {
      return MaterialPageRoute(
        builder: (_) => const LoginPage(),
        settings: settings,
      );
    }

    if (uri.path == AppRoutes.subscriptions) {
      return MaterialPageRoute(
        builder: (_) => const SubscriptionListPage(),
        settings: settings,
      );
    }

    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'subscriptions') {
      final slug = uri.pathSegments[1];

      return MaterialPageRoute(
        builder: (_) => SubscriptionDetailPage(slug: slug),
        settings: settings,
      );
    }

    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Rota não encontrada'))),
    );
  }
}
