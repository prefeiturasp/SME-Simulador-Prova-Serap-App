import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/prova_questao_entity.dart';

part 'prova_questao_model.freezed.dart';
part 'prova_questao_model.g.dart';

@freezed
abstract class ProvaQuestaoModel with _$ProvaQuestaoModel {
  ProvaQuestaoModel._();

  factory ProvaQuestaoModel({
    required int id,
    required String descricao,
    required DateTime dataInicioAplicacao,
  }) = _ProvaQuestaoModel;
  factory ProvaQuestaoModel.fromJson(Map<String, dynamic> json) => _$ProvaQuestaoModelFromJson(json);

  ProvaQuestao toModel() {
    return ProvaQuestao(
      id,
      descricao,
      dataInicioAplicacao,
    );
  }
}
