import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:serap_simulador/features/questao/data/models/questao_completa_model.dart';

part 'questao_remote_service.g.dart';

@RestApi()
@Singleton()
abstract class QuestaoRemoteService {
  @factoryMethod
  factory QuestaoRemoteService(Dio dio) = _QuestaoRemoteService;

  // @GET('prova/caderno/{cadernoId}')
  @GET('https://mocki.io/v1/72b01441-f71f-4ee9-b91c-947b46477bca')
  Future<HttpResponse<QuestaoCompletaModel>> getQuestaoCompleta({
    @Path() required int questaoId,
    @Path() required int provaId,
    @Path() required int cadernoId,
  });
}
