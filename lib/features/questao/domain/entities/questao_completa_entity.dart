import 'package:equatable/equatable.dart';

import 'alternativa_entity.dart';
import 'arquivo_entity.dart';
import 'arquivo_video_entity.dart';
import 'questao_entity.dart';

class QuestaoCompleta extends Equatable {
  final int id;
  final String caderno;
  final Questao questao;

  final List<Arquivo> audios;
  final List<ArquivoVideo> videos;

  final List<Alternativa> alternativas;

  final int? questaoAnteriorId;
  final int? proximaQuestaoId;

  QuestaoCompleta({
    required this.id,
    required this.questao,
    required this.audios,
    required this.videos,
    required this.alternativas,
    required this.caderno,
    this.questaoAnteriorId,
    this.proximaQuestaoId,
  });

  @override
  List<Object?> get props => [int];
}
