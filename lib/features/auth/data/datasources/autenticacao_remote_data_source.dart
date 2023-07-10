import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/app/network/dio_client.dart';
import 'package:serap_simulador/features/auth/data/models/autenticacao.model.dart';

import 'autenticacao_remote_service.dart';

abstract class IAutenticacaoRemoteDataSource {
  Future<AutenticacaoModel> loginByCodigoAutenticacao({required String codigo});
  Future<AutenticacaoModel> revalidar({required String token});
}

@Injectable(as: IAutenticacaoRemoteDataSource)
class AutenticacaoRemoteDataSource implements IAutenticacaoRemoteDataSource {
  AutenticacaoRemoteService autenticacaoRemoteService;

  AutenticacaoRemoteDataSource(this.autenticacaoRemoteService);

  @override
  Future<AutenticacaoModel> loginByCodigoAutenticacao({
    required String codigo,
  }) async {
    try {
      final response = await autenticacaoRemoteService.loginByCodigoAutenticacao(codigo: codigo);

      return response.data;
    } on DioException catch (e) {
      throw handleNertorkError(e);
    }
  }

  @override
  Future<AutenticacaoModel> revalidar({required String token}) async {
    try {
      final response = await autenticacaoRemoteService.revalidar(token: token);
      return response.data;
    } on DioException catch (e) {
      throw handleNertorkError(e);
    }
  }
}
