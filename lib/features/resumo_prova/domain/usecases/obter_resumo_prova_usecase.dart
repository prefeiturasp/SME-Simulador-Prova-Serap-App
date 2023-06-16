import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/features/resumo_prova/domain/repositories/i_prova_repository.dart';
import 'package:serap_simulador/features/resumo_prova/domain/entities/prova_resumo.dart';

@Singleton()
class ObterResumoProvaUseCase implements IUseCase<List<ProvaResumo>, Params> {
  final IProvaRepository repository;

  ObterResumoProvaUseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, List<ProvaResumo>>> call(Params params) async {
    var result = await repository.obterResumoByCaderno(params.cadernoId);
    return result;
  }
}

class Params extends Equatable {
  final int cadernoId;

  const Params({
    required this.cadernoId,
  });

  @override
  List<Object> get props => [cadernoId];
}
