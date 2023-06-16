// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:serap_simulador/shared/enums/tipo_questao.enum.dart';

class Questao extends Equatable {
  final int questaoLegadoId;
  final String? titulo;
  final String descricao;
  final int ordem;
  final EnumTipoQuestao tipo;

  final int quantidadeAlternativas;

  Questao({
    required this.questaoLegadoId,
    this.titulo,
    required this.descricao,
    required this.tipo,
    required this.ordem,
    required this.quantidadeAlternativas,
  });

  @override
  List<Object> get props => [questaoLegadoId, descricao, tipo];
}
