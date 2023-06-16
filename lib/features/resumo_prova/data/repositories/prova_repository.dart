import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/app/network/network_info.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/features/resumo_prova/data/dataources/prova_remote_data_source.dart';
import 'package:serap_simulador/features/resumo_prova/domain/repositories/i_prova_repository.dart';
import 'package:serap_simulador/features/resumo_prova/domain/entities/prova_resumo.dart';

@LazySingleton(as: IProvaRepository)
class ProvaRepository implements IProvaRepository {
  final INetworkInfo networkInfo;
  final IProvaRemoteDataSource provaRemoteDataSource;

  ProvaRepository(this.networkInfo, this.provaRemoteDataSource);

  @override
  Future<Either<Failure, List<ProvaResumo>>> obterResumoByCaderno(int cadernoId) async {
    try {
      if (await networkInfo.isConnected) {
        var detalhes = await provaRemoteDataSource.getResumoByCaderno(cadernoId: cadernoId);

        return Right(detalhes.map((e) => e.toDomain()).toList());
      } else {
        return Left(Failure.noConnectionFailure());
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }
}
