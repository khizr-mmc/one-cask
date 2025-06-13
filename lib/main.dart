import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:flutter/material.dart';
import 'package:general_repository/general_repository.dart';

import 'app/app.dart';
import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheClient.initializeCache();

  AppApis().initBaseUrlAndAuthEndpoints();

  final generalRepository = GeneralRepository();
  final authenticationRepository = AuthenticationRepository(generalRepository);
  await authenticationRepository.user.first;
  generalRepository.initialize(authenticationRepository);

  runApp(
    App(
      authenticationRepository: authenticationRepository,
      generalRepository: generalRepository,
    ),
  );
}
