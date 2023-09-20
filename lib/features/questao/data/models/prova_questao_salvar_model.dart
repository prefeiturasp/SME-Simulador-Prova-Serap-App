import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/prova_questao_salvar_entity.dart';

part 'prova_questao_salvar_model.freezed.dart';

part 'prova_questao_salvar_model.g.dart';

@freezed
abstract class ProvaQuestaoSalvarModel with _$ProvaQuestaoSalvarModel {
  ProvaQuestaoSalvarModel._();

  factory ProvaQuestaoSalvarModel({
    required int provaId,
    required int questaoId,
  }) = _ProvaQuestaoSalvarModel;

  factory ProvaQuestaoSalvarModel.fromJson(Map<String, dynamic> json) => _$ProvaQuestaoSalvarModelFromJson(json);

  factory ProvaQuestaoSalvarModel.fromEntity(ProvaQuestaoSalvar e) {
    return ProvaQuestaoSalvarModel(
      provaId: e.provaId,
      questaoId: e.questaoId,
    );
  }
}
