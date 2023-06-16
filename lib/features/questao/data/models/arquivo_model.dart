import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_entity.dart';

part 'arquivo_model.freezed.dart';
part 'arquivo_model.g.dart';

@freezed
abstract class ArquivoModel with _$ArquivoModel {
  ArquivoModel._();

  factory ArquivoModel({
    required int id,
    required int legadoId,
    required String caminho,
    required int questaoId,
  }) = _ArquivoModel;
  factory ArquivoModel.fromJson(Map<String, dynamic> json) => _$ArquivoModelFromJson(json);

  Arquivo toModel() {
    return Arquivo(
      id: id,
      legadoId: legadoId,
      caminho: caminho,
    );
  }
}
