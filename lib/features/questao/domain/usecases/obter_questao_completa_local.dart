import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/domain/repositories/i_questao_repository.dart';

@Singleton()
class ObterQuestaoCompletaLocal implements IUseCase<QuestaoCompleta, Params> {
  final IQuestaoRepository _repository;

  ObterQuestaoCompletaLocal(this._repository);

  @override
  Future<Either<Failure, QuestaoCompleta>> call(Params params) async {
    var result = await _repository.getQuestaoCompletaLocal(
      questaoId: params.questaoId,
      cadernoId: params.cadernoId,
    );
    return result;
  }
}

class Params extends Equatable {
  final int cadernoId;
  final int questaoId;

  const Params({
    required this.cadernoId,
    required this.questaoId,
  });

  @override
  List<Object> get props => [cadernoId, cadernoId];
}
