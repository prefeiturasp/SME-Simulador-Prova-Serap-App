// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:serap_simulador/app/network/dio_client.dart';

import '../models/questao_completa_model.dart';
import '../models/prova_questao_model.dart';
import '../models/questao_completa_salvar_model.dart';
import 'questao_remote_service.dart';

abstract class IQuestaoRemoteDataSource {
  Future<QuestaoCompletaModel> getQuestaoCompleta({
    required int questaoId,
    required int cadernoId,
  });

  Future<bool> salvarAlteracao({
    required QuestaoCompletaSalvarModel questaoCompleta,
  });

  Future<List<ProvaQuestaoModel>> getProvasPorQuestao({
    required int questaoId,
  });
}

@Injectable(as: IQuestaoRemoteDataSource)
class QuestaoRemoteDataSource implements IQuestaoRemoteDataSource {
  QuestaoRemoteService questaoRemoteService;

  QuestaoRemoteDataSource(
    this.questaoRemoteService,
  );

  @override
  Future<QuestaoCompletaModel> getQuestaoCompleta({
    required int questaoId,
    required int cadernoId,
  }) async {
    try {
      final HttpResponse<QuestaoCompletaModel> response = await questaoRemoteService.getQuestaoCompleta(
        questaoId: questaoId,
        cadernoId: cadernoId,
      );

      return response.data;
    } on DioException catch (e) {
      throw handleNertorkError(e);
    }
  }

  @override
  Future<bool> salvarAlteracao({required QuestaoCompletaSalvarModel questaoCompleta}) async {
    try {
      final HttpResponse<bool> response = await questaoRemoteService.salvarAlteracao(
          provasId: questaoCompleta.provasId,
          questao: questaoCompleta.questao,
          alternativas: questaoCompleta.alternativas);

      return response.data;
    } on DioException catch (e) {
      throw handleNertorkError(e);
    }
  }

  @override
  Future<List<ProvaQuestaoModel>> getProvasPorQuestao({required int questaoId}) async {
    try {
      final HttpResponse<List<ProvaQuestaoModel>> response = await questaoRemoteService.getProvasPorQuestao(
        questaoId: questaoId,
      );

      return response.data;
    } on DioException catch (e) {
      throw handleNertorkError(e);
    }
  }
}
