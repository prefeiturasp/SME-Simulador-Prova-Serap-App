// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_salvar_entity.dart';
import 'package:serap_simulador/shared/enums/tipo_questao.enum.dart';

@entity
class Questao extends Equatable {
  @primaryKey
  final int id;

  final String? textoBase;
  final String enunciado;
  final int ordem;
  final EnumTipoQuestao tipo;

  final int quantidadeAlternativas;

  Questao({
    required this.id,
    this.textoBase,
    required this.enunciado,
    required this.tipo,
    required this.ordem,
    required this.quantidadeAlternativas,
  });

  copyWith({
    String? textoBase,
    String? enunciado,
  }) {
    return Questao(
      id: id,
      textoBase: textoBase ?? this.textoBase,
      enunciado: enunciado ?? this.enunciado,
      tipo: tipo,
      ordem: ordem,
      quantidadeAlternativas: quantidadeAlternativas,
    );
  }

  @override
  List<Object> get props => [id, textoBase ?? '', enunciado, tipo];

  QuestaoSalvar toQuestaoSalvar() {
    return QuestaoSalvar(
      id: id,
      textoBase: textoBase,
      enunciado: enunciado,
    );
  }
}
