import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/features/questao/domain/entities/prova_questao_salvar_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/domain/repositories/i_questao_repository.dart';

@Singleton()
class SalvarAlteracoesUseCase implements IUseCaseOption<bool, ParamsSalvarAlteracoes> {
  final IQuestaoRepository _repository;

  SalvarAlteracoesUseCase(this._repository);

  @override
  Future<Option<bool>> call(ParamsSalvarAlteracoes params) async {
    await _repository.salvarAlteracao(
      questaoCompleta: params.questaoCompleta.toQuestaoSalvar(params.provasQuestoes),
    );

    return optionOf(true);
  }
}

class ParamsSalvarAlteracoes extends Equatable {
  final List<ProvaQuestaoSalvar> provasQuestoes;
  final QuestaoCompleta questaoCompleta;

  const ParamsSalvarAlteracoes({
    required this.provasQuestoes,
    required this.questaoCompleta,
  });

  @override
  List<Object> get props => [provasQuestoes, questaoCompleta];
}
