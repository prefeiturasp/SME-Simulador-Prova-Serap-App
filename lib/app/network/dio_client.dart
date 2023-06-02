import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/core/storages/local_storages.dart';
import 'package:serap_simulador/app/network/dio_interceptors/auth_interceptor.dart';
import 'package:serap_simulador/env.dart';

@module
abstract class DioClient {
  @PostConstruct(preResolve: true)
  Future<Dio> setup(LocalStorage localStorage) async {
    final options = BaseOptions(
      responseType: ResponseType.json,
      baseUrl: Env.URL_API,
    );

    final dio = Dio(options);

    final dioAuth = Dio(dio.options);
    dioAuth.interceptors.add(PrettyDioLogger(
      compact: true,
      error: true,
      request: false,
      responseBody: false,
      responseHeader: false,
      requestBody: false,
      requestHeader: false,
    ));

    dio.interceptors.add(AuthInterceptor(dioAuth));
    dio.interceptors.add(PrettyDioLogger(
      compact: true,
      error: true,
      request: false,
      responseBody: true,
      requestBody: false,
      responseHeader: false,
      requestHeader: false,
    ));

    return dio;
  }
}

extension DioErrorX on DioError {
  bool get isNoConnectionError =>
      type == DioErrorType.unknown && error is SocketException; // import 'dart:io' for SocketException
}

handleNertorkError(DioError e) {
  if (e.isNoConnectionError) {
    throw Failure.serverFailure(message: 'Erro ao se conectar com o servidor');
  }

  if (e.response != null) {
    String message = 'Erro desconhecido';
    switch (e.response!.statusCode) {
      case 401:
      case 403:
        if ((e.response!.data as Map).containsKey('errors')) {
          message = e.response!.data['errors'][0];
        } else {
          message = e.response!.data['detail'];
        }

        break;
    }

    throw Failure.serverFailure(message: message);
  } else {
    if (e.error != null) {
      throw Failure.serverFailure(message: e.error.toString());
    } else if (e.message != null) {
      throw Failure.serverFailure(message: e.message!);
    }
  }
}
