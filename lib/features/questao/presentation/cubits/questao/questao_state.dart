part of 'questao_cubit.dart';

@freezed
class QuestaoState with _$QuestaoState {
  const factory QuestaoState.inicial() = _Inicial;
  const factory QuestaoState.carregando() = _Carregando;
  const factory QuestaoState.carregado(QuestaoCompleta questaoCompleta) = _Carregado;
  const factory QuestaoState.erro(String erro) = _Erro;
}
