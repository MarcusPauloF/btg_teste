import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_router.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'features/subscriptions/data/datasources/subscription_remote_datasource.dart';
import 'features/subscriptions/data/repositories/subscription_repository.dart';
import 'features/subscriptions/presentation/blocs/subscriptions/subscription_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(AuthRepository(AuthRemoteDatasource())),
        ),
        BlocProvider<SubscriptionBloc>(
          create: (_) => SubscriptionBloc(
            SubscriptionRepository(SubscriptionRemoteDatasource()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Empiricus App',
        onGenerateRoute: AppRouter.onGenerateRoute,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const Scaffold(body: Center(child: Text('Hello, Flutter!'))),
      ),
    );
  }
}
