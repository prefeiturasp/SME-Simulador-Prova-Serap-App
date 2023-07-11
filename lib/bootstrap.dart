import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'core/utils/tela_adaptativa.dart';
import 'injector.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required String environment,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  registerFonts();
  TelaAdaptativaUtil().setup();

  await configureDependencies(environment: environment);

  // FlutterError.onError = (details) {
  //   log(details.exceptionAsString(), stackTrace: details.stack);
  // };

  runApp(await builder());
}

void registerFonts() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['fonts'], license);
  });
}
