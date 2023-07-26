import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:serap_simulador/features/questao/data/models/prova_questao_model.dart';

import '../models/alternativa_salvar_model.dart';
import '../models/prova_questao_salvar_model.dart';
import '../models/questao_completa_model.dart';
import '../models/questao_salvar_model.dart';

part 'questao_remote_service.g.dart';

@RestApi()
@Singleton()
abstract class QuestaoRemoteService {
  @factoryMethod
  factory QuestaoRemoteService(Dio dio) = _QuestaoRemoteService;

  @GET('questao/completa')
  Future<HttpResponse<QuestaoCompletaModel>> getQuestaoCompleta({
    @Query('cadernoId') required int cadernoId,
    @Query('questaoId') required int questaoId,
  });

  @POST('questao/salvar-alteracao2')
  Future<HttpResponse<bool>> salvarAlteracao({
    @Field() required List<ProvaQuestaoSalvarModel> provasQuestoes,
    @Field() required QuestaoSalvarModel questao,
    @Field() required List<AlternativaSalvarModel> alternativas,
  });

  @GET('questao/{questaoId}/provas')
  Future<HttpResponse<List<ProvaQuestaoModel>>> getProvasPorQuestao({
    @Path() required int questaoId,
  });
}
