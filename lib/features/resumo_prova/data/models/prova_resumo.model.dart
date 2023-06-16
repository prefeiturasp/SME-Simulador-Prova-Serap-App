import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/resumo_prova/domain/entities/prova_resumo.dart';

part 'prova_resumo.model.freezed.dart';
part 'prova_resumo.model.g.dart';

@freezed
abstract class ProvaResumoModel with _$ProvaResumoModel {
  ProvaResumoModel._();

  factory ProvaResumoModel({
    required int id,
    @JsonKey(name: 'textoBase') String? titulo,
    @JsonKey(name: 'enunciado') required String descricao,
    required String caderno,
    required int ordem,
  }) = _ProvaResumoModel;
  factory ProvaResumoModel.fromJson(Map<String, dynamic> json) => _$ProvaResumoModelFromJson(json);

  ProvaResumo toDomain() {
    return ProvaResumo(
      id: id,
      descricao: descricao,
      titulo: titulo,
      caderno: caderno,
      ordem: ordem,
    );
  }
}
