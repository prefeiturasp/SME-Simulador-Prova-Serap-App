import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_salvar_entity.dart';

import 'alternativa_salvar_model.dart';
import 'questao_salvar_model.dart';

part 'questao_completa_salvar_model.freezed.dart';
part 'questao_completa_salvar_model.g.dart';

@freezed
abstract class QuestaoCompletaSalvarModel with _$QuestaoCompletaSalvarModel {
  QuestaoCompletaSalvarModel._();

  factory QuestaoCompletaSalvarModel({
    required List<int> provasId,
    required QuestaoSalvarModel questao,
    required List<AlternativaSalvarModel> alternativas,
  }) = _QuestaoCompletaSalvarModel;

  factory QuestaoCompletaSalvarModel.fromJson(Map<String, dynamic> json) => _$QuestaoCompletaSalvarModelFromJson(json);

  factory QuestaoCompletaSalvarModel.fromEntity(QuestaoCompletaSalvar questaoCompletaSalvar) {
    return QuestaoCompletaSalvarModel(
      provasId: questaoCompletaSalvar.provasId,
      questao: QuestaoSalvarModel.fromEntity(questaoCompletaSalvar.questao),
      alternativas: questaoCompletaSalvar.alternativas.map((e) => AlternativaSalvarModel.fromEntity(e)).toList(),
    );
  }
}
