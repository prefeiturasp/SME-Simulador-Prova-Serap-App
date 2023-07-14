import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_salvar_entity.dart';

part 'questao_salvar_model.freezed.dart';
part 'questao_salvar_model.g.dart';

@freezed
abstract class QuestaoSalvarModel with _$QuestaoSalvarModel {
  QuestaoSalvarModel._();

  factory QuestaoSalvarModel({
    required int id,
    required String? textoBase,
    required String enunciado,
  }) = _QuestaoSalvarModel;

  factory QuestaoSalvarModel.fromJson(Map<String, dynamic> json) => _$QuestaoSalvarModelFromJson(json);

  factory QuestaoSalvarModel.fromEntity(QuestaoSalvar questao) {
    return QuestaoSalvarModel(
      id: questao.id,
      textoBase: questao.textoBase,
      enunciado: questao.enunciado,
    );
  }
}
