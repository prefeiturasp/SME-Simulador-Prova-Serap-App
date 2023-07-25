import 'package:freezed_annotation/freezed_annotation.dart';

enum EnumFileType {
  @JsonValue(1)
  texto_base(1),

  @JsonValue(2)
  alternativa(2),

  @JsonValue(3)
  justificativa(3),

  @JsonValue(4)
  enunciado(4),

  @JsonValue(5)
  prova(5);

  final int id;

  const EnumFileType(this.id);
}
