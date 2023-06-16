import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:serap_simulador/features/resumo_prova/data/models/prova_resumo.model.dart';

part 'prova_remote_service.g.dart';

@RestApi()
@Singleton()
abstract class ProvaRemoteService {
  @factoryMethod
  factory ProvaRemoteService(Dio dio) = _ProvaRemoteService;

  @GET('prova/caderno/{cadernoId}')
  // @GET('https://6481ddf429fa1c5c50323694.mockapi.io/api/v1/resumo')
  Future<HttpResponse<List<ProvaResumoModel>>> getResumoByCaderno({
    @Path() required int cadernoId,
  });
}
