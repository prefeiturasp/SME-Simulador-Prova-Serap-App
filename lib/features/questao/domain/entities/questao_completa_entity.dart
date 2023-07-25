import 'package:equatable/equatable.dart';
import 'package:serap_simulador/features/questao/domain/entities/prova_questao_salvar_entity.dart';

import 'alternativa_entity.dart';
import 'arquivo_entity.dart';
import 'arquivo_video_entity.dart';
import 'questao_completa_salvar_entity.dart';
import 'questao_entity.dart';

class QuestaoCompleta extends Equatable {
  final int id;
  final String caderno;
  final Questao questao;
  final bool isProvaIniciada;

  final List<Arquivo> audios;
  final List<ArquivoVideo> videos;

  final List<Alternativa> alternativas;

  final int? questaoAnteriorId;
  final int? proximaQuestaoId;

  QuestaoCompleta({
    required this.id,
    required this.caderno,
    required this.isProvaIniciada,
    required this.questao,
    required this.audios,
    required this.videos,
    required this.alternativas,
    this.questaoAnteriorId,
    this.proximaQuestaoId,
  });

  copyWith({Questao? questao, List<Alternativa>? alternativas}) {
    return QuestaoCompleta(
      id: id,
      caderno: caderno,
      isProvaIniciada: isProvaIniciada,
      questao: questao ?? this.questao,
      audios: audios,
      videos: videos,
      alternativas: alternativas ?? this.alternativas,
      proximaQuestaoId: proximaQuestaoId,
      questaoAnteriorId: questaoAnteriorId,
    );
  }

  QuestaoCompletaSalvar toQuestaoSalvar(List<ProvaQuestaoSalvar> provasQuestao) {
    return QuestaoCompletaSalvar(
      provasQuestoes: provasQuestao,
      questao: questao.toQuestaoSalvar(),
      alternativas: alternativas.map((e) => e.toAlternativaSalvar()).toList(),
    );
  }

  @override
  List<Object?> get props => [id, caderno, questao, alternativas];
}
