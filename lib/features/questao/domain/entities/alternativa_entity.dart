import 'package:equatable/equatable.dart';

class Alternativa extends Equatable {
  final int id;
  final int questaoLegadoId;
  final String descricao;
  final int ordem;
  final String numeracao;

  Alternativa({
    required this.id,
    required this.questaoLegadoId,
    required this.descricao,
    required this.ordem,
    required this.numeracao,
  });

  @override
  List<Object> get props => [id, questaoLegadoId, descricao, ordem, numeracao];
}
