import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/prova_questao_entity.dart';

part 'prova_questao_model.freezed.dart';
part 'prova_questao_model.g.dart';

@freezed
abstract class ProvaQuestaoModel with _$ProvaQuestaoModel {
  ProvaQuestaoModel._();

  factory ProvaQuestaoModel({
    required int id,
    required int questaoId,
    required String descricao,
    required DateTime dataInicioAplicacao,
    @Default('Não definido') String componenteCurricular,
    @Default(1) int versao,
  }) = _ProvaQuestaoModel;
  factory ProvaQuestaoModel.fromJson(Map<String, dynamic> json) => _$ProvaQuestaoModelFromJson(json);

  ProvaQuestao toModel() {
    return ProvaQuestao(
      id: id,
      questaoId: questaoId,
      descricao: descricao,
      dataInicioAplicacao: dataInicioAplicacao,
      componenteCurricular: componenteCurricular,
      versao: versao,
    );
  }
}
