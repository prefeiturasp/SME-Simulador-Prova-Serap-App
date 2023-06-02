import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'injector.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required String environment,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies(environment: environment);

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(await builder());
}
