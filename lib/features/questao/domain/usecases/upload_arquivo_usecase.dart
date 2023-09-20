import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_upload_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_url_entity.dart';
import 'package:serap_simulador/features/questao/domain/repositories/i_arquivo_repository.dart';

@Singleton()
class UploadArquivoUseCase implements IUseCase<ArquivoUrl, Params> {
  final IArquivoRepository _repository;

  UploadArquivoUseCase(this._repository);

  @override
  Future<Either<Failure, ArquivoUrl>> call(Params params) async {
    var result = await _repository.uploadFile(
      arquivoUpload: params.arquivoUpload,
    );
    return result;
  }
}

class Params extends Equatable {
  final ArquivoUpload arquivoUpload;

  const Params({
    required this.arquivoUpload,
  });

  @override
  List<Object> get props => [arquivoUpload];
}
