import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/features/questao/domain/entities/prova_questao_entity.dart';
import 'package:serap_simulador/features/questao/domain/repositories/i_questao_repository.dart';

@Singleton()
class ObterProvasDaQuestaoUseCase implements IUseCase<List<ProvaQuestao>, Params> {
  final IQuestaoRepository _repository;

  ObterProvasDaQuestaoUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProvaQuestao>>> call(Params params) async {
    var result = await _repository.getProvasPorQuestao(
      questaoId: params.questaoId,
    );
    return result;
  }
}

class Params extends Equatable {
  final int questaoId;

  const Params({
    required this.questaoId,
  });

  @override
  List<Object> get props => [questaoId];
}
