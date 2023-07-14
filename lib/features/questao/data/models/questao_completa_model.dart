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
    @JsonKey(name: 'ehProvaIniciada') required bool isProvaIniciada,
    @JsonKey(name: 'textoBase') String? textoBase,
    @JsonKey(name: 'enunciado') required String enunciado,
    required int ordem,
    @JsonKey(name: 'tipoItem') required EnumTipoQuestao tipo,
    required int quantidadeAlternativas,
    required String caderno,
    required List<ArquivoModel> audios,
    required List<ArquivoVideoModel> videos,
    required List<AlternativaModel> alternativas,
    int? questaoAnteriorId,
    int? proximaQuestaoId,
  }) = _QuestaoCompletaModel;
  factory QuestaoCompletaModel.fromJson(Map<String, dynamic> json) => _$QuestaoCompletaModelFromJson(json);

  QuestaoCompleta toModel() {
    return QuestaoCompleta(
      id: id,
      caderno: caderno,
      isProvaIniciada: isProvaIniciada,
      questao: Questao(
        id: id,
        textoBase: textoBase,
        enunciado: enunciado,
        tipo: tipo,
        ordem: ordem,
        quantidadeAlternativas: quantidadeAlternativas,
      ),
      audios: audios.map((e) => e.toModel()).toList(),
      videos: videos.map((e) => e.toModel()).toList(),
      alternativas: alternativas.map((e) => e.toModel()).toList(),
      questaoAnteriorId: questaoAnteriorId,
      proximaQuestaoId: proximaQuestaoId,
    );
  }

  factory QuestaoCompletaModel.fromEntity(QuestaoCompleta questaoCompleta) {
    return QuestaoCompletaModel(
      id: questaoCompleta.id,
      isProvaIniciada: questaoCompleta.isProvaIniciada,
      //
      enunciado: questaoCompleta.questao.enunciado,
      textoBase: questaoCompleta.questao.textoBase,
      ordem: questaoCompleta.questao.ordem,
      tipo: questaoCompleta.questao.tipo,
      quantidadeAlternativas: questaoCompleta.questao.quantidadeAlternativas,
      caderno: questaoCompleta.caderno,
      //
      audios: questaoCompleta.audios.map((e) => ArquivoModel.fromModel(e)).toList(),
      videos: questaoCompleta.videos.map((e) => ArquivoVideoModel.fromModel(e)).toList(),
      //
      alternativas: questaoCompleta.alternativas.map((e) => AlternativaModel.fromModel(e)).toList(),
      //
      proximaQuestaoId: questaoCompleta.proximaQuestaoId,
      questaoAnteriorId: questaoCompleta.questaoAnteriorId,
    );
  }
}
