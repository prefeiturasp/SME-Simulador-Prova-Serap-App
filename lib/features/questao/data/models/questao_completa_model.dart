import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_entity.dart';
import 'package:serap_simulador/shared/enums/tipo_questao.enum.dart';

import 'alternativa_model.dart';
import 'arquivo_model.dart';
import 'arquivo_video_model.dart';

part 'questao_completa_model.freezed.dart';
part 'questao_completa_model.g.dart';

@freezed
abstract class QuestaoCompletaModel with _$QuestaoCompletaModel {
  QuestaoCompletaModel._();

  factory QuestaoCompletaModel({
    required int id,
    String? titulo,
    required String descricao,
    required int ordem,
    required EnumTipoQuestao tipo,
    required int quantidadeAlternativas,
    required List<ArquivoModel> arquivos,
    required List<ArquivoModel> audios,
    required List<ArquivoVideoModel> videos,
    required List<AlternativaModel> alternativas,
  }) = _QuestaoCompletaModel;
  factory QuestaoCompletaModel.fromJson(Map<String, dynamic> json) => _$QuestaoCompletaModelFromJson(json);

  QuestaoCompleta toModel() {
    return QuestaoCompleta(
      id: id,
      questao: Questao(
        questaoLegadoId: id,
        descricao: descricao,
        tipo: tipo,
        ordem: ordem,
        quantidadeAlternativas: quantidadeAlternativas,
      ),
      imagens: arquivos.map((e) => e.toModel()).toList(),
      audios: audios.map((e) => e.toModel()).toList(),
      videos: videos.map((e) => e.toModel()).toList(),
      alternativas: alternativas.map((e) => e.toModel()).toList(),
    );
  }
}
