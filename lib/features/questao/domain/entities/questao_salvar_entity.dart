import 'package:equatable/equatable.dart';

class QuestaoSalvar extends Equatable {
  final int id;
  final String? textoBase;
  final String enunciado;

  QuestaoSalvar({
    required this.id,
    required this.textoBase,
    required this.enunciado,
  });

  @override
  List<Object> get props => [id, textoBase ?? '', enunciado];
}
