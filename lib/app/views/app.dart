import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_repository/general_repository.dart';
import 'package:one_cask/auth/auth.dart';
import 'package:one_cask/onboarding/views/views.dart';

import '../../utils/utils.dart';
import '../app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authenticationRepository,
    required this.generalRepository,
  });

  final AuthenticationRepository authenticationRepository;
  final GeneralRepository generalRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: generalRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppCubit(authenticationRepository)..initializeApp(),
          ),
          BlocProvider(create: (_) => AuthenticationCubit()),
        ],
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "One Cask",
      navigatorKey: navigatorKey,
      theme: AppTheme().themeData,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: const TextScaler.linear(1.0), boldText: false),
        child: child!,
      ),
      home: _AppPages(),
    );
  }
}

class _AppPages extends StatelessWidget {
  const _AppPages();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) =>
          previous.showOnboarding != current.showOnboarding,
      builder: (context, state) {
        if (state.showOnboarding) {
          return const SplashPage();
        } else {
          return const SplashPage();
        }
      },
    );
  }
}
