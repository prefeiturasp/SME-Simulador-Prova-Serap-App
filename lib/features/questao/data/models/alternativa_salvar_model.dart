import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/alternativa_salvar_entity.dart';

part 'alternativa_salvar_model.freezed.dart';
part 'alternativa_salvar_model.g.dart';

@freezed
abstract class AlternativaSalvarModel with _$AlternativaSalvarModel {
  AlternativaSalvarModel._();

  factory AlternativaSalvarModel({
    required int id,
    required String descricao,
  }) = _AlternativaSalvarModel;

  factory AlternativaSalvarModel.fromJson(Map<String, dynamic> json) => _$AlternativaSalvarModelFromJson(json);

  factory AlternativaSalvarModel.fromModel(AlternativaSalvar entity) {
    return AlternativaSalvarModel(
      id: entity.id,
      descricao: entity.descricao,
    );
  }
}
