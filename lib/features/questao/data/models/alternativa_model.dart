import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/alternativa_entity.dart';

part 'alternativa_model.freezed.dart';
part 'alternativa_model.g.dart';

@freezed
abstract class AlternativaModel with _$AlternativaModel {
  AlternativaModel._();

  factory AlternativaModel({
    required int id,
    @JsonKey(name: 'questaoId') required int questaoLegadoId,
    required String descricao,
    required int ordem,
    required String numeracao,
  }) = _AlternativaModel;
  factory AlternativaModel.fromJson(Map<String, dynamic> json) => _$AlternativaModelFromJson(json);

  Alternativa toModel() {
    return Alternativa(
      id: id,
      questaoLegadoId: questaoLegadoId,
      descricao: descricao,
      ordem: ordem,
      numeracao: numeracao,
    );
  }
}