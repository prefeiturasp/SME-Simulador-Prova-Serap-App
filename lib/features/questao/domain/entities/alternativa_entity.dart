import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:serap_simulador/features/questao/domain/entities/alternativa_salvar_entity.dart';

@entity
class Alternativa extends Equatable {
  @primaryKey
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

  Alternativa copyWith({
    String? descricao,
  }) {
    return Alternativa(
      id: id,
      questaoId: questaoId,
      descricao: descricao ?? '',
      ordem: ordem,
      numeracao: numeracao,
    );
  }

  AlternativaSalvar toAlternativaSalvar() {
    return AlternativaSalvar(
      id: id,
      descricao: descricao,
    );
  }
}
