// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/app/network/dio_client.dart';
import 'package:serap_simulador/features/questao/data/models/questao_completa_model.dart';

import 'questao_remote_service.dart';

abstract class IQuestaoRemoteDataSource {
  Future<QuestaoCompletaModel> getQuestaoCompleta({
    required int questaoId,
    required int cadernoId,
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
      final response = await questaoRemoteService.getQuestaoCompleta(
        questaoId: questaoId,
        cadernoId: cadernoId,
      );

      return response.data;
    } on DioError catch (e) {
      throw handleNertorkError(e);
    }
  }
}
