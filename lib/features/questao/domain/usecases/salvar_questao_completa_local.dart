import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/domain/repositories/i_questao_repository.dart';

@Singleton()
class SalvarQuestaoCompletaLocal implements IUseCaseOption<bool, ParamsSalvarQuestaoCompleta> {
  final IQuestaoRepository _repository;

  SalvarQuestaoCompletaLocal(this._repository);

  @override
  Future<Option<bool>> call(ParamsSalvarQuestaoCompleta params) async {
    await _repository.salvarQuestaoCompletaLocal(
      questaoCompleta: params.questaoCompleta,
    );

    return optionOf(true);
  }
}

class ParamsSalvarQuestaoCompleta extends Equatable {
  final QuestaoCompleta questaoCompleta;

  const ParamsSalvarQuestaoCompleta({
    required this.questaoCompleta,
  });

  @override
  List<Object> get props => [questaoCompleta];
}
