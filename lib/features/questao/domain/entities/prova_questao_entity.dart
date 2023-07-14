// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProvaQuestao extends Equatable {
  final int id;
  final String descricao;
  final DateTime dataInicioAplicacao;
  final String componenteCurricular;
  final int versao;

  ProvaQuestao({
    required this.id,
    required this.descricao,
    required this.dataInicioAplicacao,
    required this.componenteCurricular,
    required this.versao,
  });

  @override
  List<Object> get props => [id, descricao, dataInicioAplicacao, componenteCurricular, versao];
}
