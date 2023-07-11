import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_entity.dart';

part 'arquivo_model.freezed.dart';
part 'arquivo_model.g.dart';

@freezed
abstract class ArquivoModel with _$ArquivoModel {
  ArquivoModel._();

  factory ArquivoModel({
    required int id,
    int? tamanhoBytes,
    required String caminho,
  }) = _ArquivoModel;
  factory ArquivoModel.fromJson(Map<String, dynamic> json) => _$ArquivoModelFromJson(json);

  Arquivo toModel() {
    return Arquivo(
      id: id,
      caminho: caminho,
    );
  }

  factory ArquivoModel.fromModel(Arquivo arquivo) {
    return ArquivoModel(
      id: arquivo.id,
      caminho: arquivo.caminho,
    );
  }
}
