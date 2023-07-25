import 'package:equatable/equatable.dart';

class QuestaoSalvar extends Equatable {
  final String? textoBase;
  final String enunciado;

  QuestaoSalvar({
    required this.textoBase,
    required this.enunciado,
  });

  @override
  List<Object> get props => [textoBase ?? '', enunciado];
}
