import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
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

    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Rota não encontrada'))),
    );
  }
}
