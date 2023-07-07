import 'package:equatable/equatable.dart';

import 'alternativa_bean.dart';

class QuestaoCompletaBean extends Equatable {
  final int id;
  final String textoBase;
  final String enunciado;

  final List<AlternativaBean> alternativas;

  QuestaoCompletaBean(
    this.id,
    this.textoBase,
    this.enunciado,
    this.alternativas,
  );

  @override
  List<Object> get props => [id, textoBase, enunciado, alternativas];
}
