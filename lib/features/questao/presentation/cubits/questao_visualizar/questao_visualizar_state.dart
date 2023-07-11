part of 'questao_visualizar_cubit.dart';

@freezed
class QuestaoVisualizarState with _$QuestaoVisualizarState {
  const factory QuestaoVisualizarState.inicial() = _Inicial;
  const factory QuestaoVisualizarState.carregando() = _Carregando;
  const factory QuestaoVisualizarState.carregado(QuestaoCompleta questaoCompleta) = _Carregado;
  const factory QuestaoVisualizarState.erro(String erro) = _Erro;
}
