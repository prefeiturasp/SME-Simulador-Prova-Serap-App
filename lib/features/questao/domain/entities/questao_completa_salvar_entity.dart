import 'package:equatable/equatable.dart';

import 'questao_salvar_entity.dart';
import 'alternativa_salvar_entity.dart';

class QuestaoCompletaSalvar extends Equatable {
  final List<int> provasId;
  final QuestaoSalvar questao;
  final List<AlternativaSalvar> alternativas;

  QuestaoCompletaSalvar({
    required this.provasId,
    required this.questao,
    required this.alternativas,
  });

  @override
  List<Object> get props => [provasId, questao, alternativas];
}
