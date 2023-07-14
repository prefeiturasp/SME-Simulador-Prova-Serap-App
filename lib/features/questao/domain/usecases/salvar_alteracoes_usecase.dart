import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/domain/repositories/i_questao_repository.dart';

@Singleton()
class SalvarAlteracoesUseCase implements IUseCaseOption<bool, ParamsSalvarAlteracoes> {
  final IQuestaoRepository _repository;

  SalvarAlteracoesUseCase(this._repository);

  @override
  Future<Option<bool>> call(ParamsSalvarAlteracoes params) async {
    await _repository.salvarAlteracao(
      questaoCompleta: params.questaoCompleta.toQuestaoSalvar(params.provasId),
    );

    return optionOf(true);
  }
}

class ParamsSalvarAlteracoes extends Equatable {
  final List<int> provasId;
  final QuestaoCompleta questaoCompleta;

  const ParamsSalvarAlteracoes({
    required this.provasId,
    required this.questaoCompleta,
  });

  @override
  List<Object> get props => [provasId, questaoCompleta];
}
