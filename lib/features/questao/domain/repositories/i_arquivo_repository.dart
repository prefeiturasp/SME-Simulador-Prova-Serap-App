import 'package:dartz/dartz.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_upload_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_url_entity.dart';

abstract class IArquivoRepository {
  Future<Either<Failure, ArquivoUrl>> uploadFile({
    required ArquivoUpload arquivoUpload,
  });
}
