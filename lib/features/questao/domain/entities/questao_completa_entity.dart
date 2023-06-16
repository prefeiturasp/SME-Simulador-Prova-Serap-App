import 'package:equatable/equatable.dart';

import 'alternativa_entity.dart';
import 'arquivo_entity.dart';
import 'arquivo_video_entity.dart';
import 'questao_entity.dart';

class QuestaoCompleta extends Equatable {
  final int id;
  final Questao questao;

  final List<Arquivo> imagens;
  final List<Arquivo> audios;
  final List<ArquivoVideo> videos;

  final List<Alternativa> alternativas;

  QuestaoCompleta({
    required this.id,
    required this.questao,
    required this.imagens,
    required this.audios,
    required this.videos,
    required this.alternativas,
  });

  @override
  List<Object?> get props => [int];
}
