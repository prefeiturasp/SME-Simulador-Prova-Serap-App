import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/app/network/network_info.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/features/questao/data/datasources/questao_remote_data_source.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/domain/repositories/i_questao_repository.dart';

@LazySingleton(as: IQuestaoRepository)
class QuestaoRepository implements IQuestaoRepository {
  final INetworkInfo networkInfo;
  final IQuestaoRemoteDataSource provaRemoteDataSource;

  QuestaoRepository(this.networkInfo, this.provaRemoteDataSource);

  @override
  Future<Either<Failure, QuestaoCompleta>> getQuestaoCompleta({
    required int questaoId,
    required int provaId,
    required int cadernoId,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        var detalhes = await provaRemoteDataSource.getQuestaoCompleta(
          questaoId: questaoId,
          provaId: provaId,
          cadernoId: cadernoId,
        );

        return Right(detalhes.toModel());
      } else {
        return Left(Failure.noConnectionFailure());
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }
}
