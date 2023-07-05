import 'package:equatable/equatable.dart';

class Alternativa extends Equatable {
  final int id;
  final int questaoId;
  final String descricao;
  final int ordem;
  final String numeracao;

  Alternativa({
    required this.id,
    required this.questaoId,
    required this.descricao,
    required this.ordem,
    required this.numeracao,
  });

  @override
  List<Object> get props => [id, questaoId, descricao, ordem, numeracao];
}
