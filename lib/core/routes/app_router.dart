import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {

    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Rota não encontrada'),
        ),
      ),
    );
  }
}
