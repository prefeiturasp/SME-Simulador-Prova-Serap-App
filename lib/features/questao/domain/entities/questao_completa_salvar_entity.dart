import 'package:equatable/equatable.dart';

import 'prova_questao_salvar_entity.dart';
import 'questao_salvar_entity.dart';
import 'alternativa_salvar_entity.dart';

class QuestaoCompletaSalvar extends Equatable {
  final List<ProvaQuestaoSalvar> provasQuestoes;
  final QuestaoSalvar questao;
  final List<AlternativaSalvar> alternativas;

  QuestaoCompletaSalvar({
    required this.provasQuestoes,
    required this.questao,
    required this.alternativas,
  });

  @override
  List<Object> get props => [provasQuestoes, questao, alternativas];
}
