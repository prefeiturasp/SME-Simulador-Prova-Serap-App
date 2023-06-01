import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:serap_simulador/features/auth/data/models/autenticacao.model.dart';

part 'autenticacao_remote_service.g.dart';

@RestApi()
@singleton
abstract class AutenticacaoRemoteService {
  @factoryMethod
  factory AutenticacaoRemoteService(Dio dio) = _AutenticacaoRemoteService;

  @POST('admin/autenticacao/validar')
  @Headers({'requiresToken': false})
  Future<HttpResponse<AutenticacaoModel>> loginByCodigoAutenticacao({
    @Field() required String codigo,
  });

  @POST('admin/autenticacao/revalidar')
  Future<HttpResponse<AutenticacaoModel>> revalidar({
    @Field() required String token,
  });
}
