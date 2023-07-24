// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:serap_simulador/app/network/network_info.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/features/questao/data/datasources/arquivo_remote_service.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_upload_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_url_entity.dart';
import 'package:serap_simulador/features/questao/domain/repositories/i_arquivo_repository.dart';

@LazySingleton(as: IArquivoRepository)
class ArquivoRepository implements IArquivoRepository {
  final INetworkInfo _networkInfo;
  final ArquivoRemoteService _arquivoRemoteService;

  ArquivoRepository(
    this._networkInfo,
    this._arquivoRemoteService,
  );

  @override
  Future<Either<Failure, ArquivoUrl>> uploadFile({required ArquivoUpload arquivoUpload}) async {
    try {
      if (await _networkInfo.isConnected) {
        var result = await _arquivoRemoteService.uploadArquivo(
          contentLength: arquivoUpload.contentLength,
          contentType: arquivoUpload.contentType,
          fileName: arquivoUpload.fileName,
          inputStream: arquivoUpload.inputStream,
          fileType: arquivoUpload.fileType.id,
        );

        return Right(result.data.toModel());
      } else {
        return Left(Failure.noConnectionFailure());
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }
}
