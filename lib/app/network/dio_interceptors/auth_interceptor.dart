import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:serap_simulador/app/router/app_router.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';
import 'package:serap_simulador/env.dart';
import 'package:serap_simulador/features/auth/data/datasources/autenticacao_local_datasource.dart';
import 'package:serap_simulador/features/auth/data/models/autenticacao.model.dart';
import 'package:serap_simulador/injector.dart';

enum TokenErrorType { tokenNotFound, refreshTokenHasExpired, failedToRegeneratetoken, invalidtoken }

enum TokenHeader { none }

class AuthInterceptor extends QueuedInterceptor {
  final _autenticacaoLocalDataSource = sl<IAutenticacaoLocalDataSource>();
  final Dio _dio;

  AuthInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["requiresToken"] == false) {
      options.headers.remove("requiresToken");
      return handler.next(options);
    }

    AutenticacaoModel? authData = await _autenticacaoLocalDataSource.getLastToken();

    if (authData == null) {
      await _performLogout();

      final error = DioError(
        requestOptions: options..extra["tokenErrorType"] = TokenErrorType.tokenNotFound,
        type: DioErrorType.unknown,
        message: 'Token nao encontrado',
      );
      return handler.reject(error);
    }

    String token = authData.token;

    final tokenHasExpired = Jwt.isExpired(token);

    var refreshed = true;

    if (tokenHasExpired) {
      try {
        var newtoken = await _regeneratetoken();

        if (newtoken != null) {
          token = newtoken;
          refreshed = true;
        } else {
          refreshed = false;
        }
      } on DioError catch (e) {
        debugPrint('Erro ao atualizar token: $e');
        refreshed = false;
      }
    }

    if (refreshed) {
      options.headers["Authorization"] = "Bearer $token";
      return handler.next(options);
    } else {
      final error = DioError(
        requestOptions: options..extra["tokenErrorType"] = TokenErrorType.failedToRegeneratetoken,
        type: DioErrorType.unknown,
        message: 'Falha ao regenerar o token de acesso',
      );
      return handler.reject(error);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _performLogout();

      err = DioError(
        type: DioErrorType.unknown,
        requestOptions: err.requestOptions..extra["tokenErrorType"] = TokenErrorType.invalidtoken,
        message: 'Token de acesso inválido',
      );
    }

    return handler.next(err);
  }

  Future<void> _performLogout() async {
    await _autenticacaoLocalDataSource.apagarToken();
    await sl<AppRouter>().replaceAll([LoginRoute()]);
  }

  Future<String?> _regeneratetoken() async {
    debugPrint('Atualizando token');

    var authData = await _autenticacaoLocalDataSource.getLastToken();
    final refreshToken = authData!.token;

    final response = await _dio.post(
      "${Env.URL_API}/autenticacao/token/atualizar/",
      data: {'refresh': refreshToken},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final newToken = response.data["access"];
      await _autenticacaoLocalDataSource.atualizarToken(newToken);

      return newToken;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      _performLogout();
    }

    return null;
  }
}
