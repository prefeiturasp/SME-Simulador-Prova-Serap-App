// ignore_for_file: constant_identifier_names

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'URL_API')
  static const String URL_API = _Env.URL_API;

  @EnviedField(varName: 'CHAVE_API')
  static const String CHAVE_API = _Env.CHAVE_API;
}
