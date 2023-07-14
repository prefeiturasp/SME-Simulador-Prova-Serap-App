import 'package:equatable/equatable.dart';

class ProvaQuestao extends Equatable {
  final int id;
  final String descricao;
  final DateTime dataInicioAplicacao;

  ProvaQuestao(
    this.id,
    this.descricao,
    this.dataInicioAplicacao,
  );

  @override
  List<Object> get props => [id, descricao, dataInicioAplicacao];
}
