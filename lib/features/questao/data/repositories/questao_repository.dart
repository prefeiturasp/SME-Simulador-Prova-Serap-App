import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/app/network/network_info.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/core/storages/local_storages.dart';
import 'package:serap_simulador/features/questao/data/datasources/questao_remote_data_source.dart';
import 'package:serap_simulador/features/questao/data/models/questao_completa_model.dart';
import 'package:serap_simulador/features/questao/domain/entities/prova_questao_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_salvar_entity.dart';
import 'package:serap_simulador/features/questao/domain/repositories/i_questao_repository.dart';

import '../models/questao_completa_salvar_model.dart';

@LazySingleton(as: IQuestaoRepository)
class QuestaoRepository implements IQuestaoRepository {
  final INetworkInfo _networkInfo;
  final IQuestaoRemoteDataSource _provaRemoteDataSource;
  final LocalStorage _localStorage;

  QuestaoRepository(this._networkInfo, this._provaRemoteDataSource, this._localStorage);

  @override
  Future<Either<Failure, QuestaoCompleta>> getQuestaoCompleta({
    required int questaoId,
    required int cadernoId,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        var detalhes = await _provaRemoteDataSource.getQuestaoCompleta(
          questaoId: questaoId,
          cadernoId: cadernoId,
        );

        await _localStorage.saveQuestaoCompleta(detalhes);

        return Right(detalhes.toModel());
      } else {
        return Left(Failure.noConnectionFailure());
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, QuestaoCompleta>> getQuestaoCompletaLocal({
    required int questaoId,
    required int cadernoId,
  }) async {
    try {
      QuestaoCompletaModel? questao = await _localStorage.getQuestaoCompleta(questaoId);

      if (questao != null) {
        return Right(questao.toModel());
      } else {
        var questaoCompleta = getQuestaoCompleta(questaoId: questaoId, cadernoId: cadernoId);
        return questaoCompleta;
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> salvarQuestaoCompletaLocal({
    required QuestaoCompleta questaoCompleta,
  }) async {
    try {
      var result = await _localStorage.saveQuestaoCompleta(QuestaoCompletaModel.fromEntity(questaoCompleta));

      if (result) {
        return Right(true);
      } else {
        return Right(false);
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProvaQuestao>>> getProvasPorQuestao({required int questaoId}) async {
    try {
      if (await _networkInfo.isConnected) {
        var detalhes = await _provaRemoteDataSource.getProvasPorQuestao(
          questaoId: questaoId,
        );

        return Right(detalhes.map((e) => e.toModel()).toList());
      } else {
        return Left(Failure.noConnectionFailure());
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> salvarAlteracao({required QuestaoCompletaSalvar questaoCompleta}) async {
    try {
      var result = await _provaRemoteDataSource.salvarAlteracao(
          questaoCompleta: QuestaoCompletaSalvarModel.fromEntity(questaoCompleta));

      if (result) {
        return Right(true);
      } else {
        return Right(false);
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }
}
