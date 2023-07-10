part of 'questao_editar_cubit.dart';

enum Status {
  inicial,
  carregando,
  carregado,
  erro,
}

@freezed
class QuestaoEditarState with _$QuestaoEditarState {
  const factory QuestaoEditarState({
    QuestaoCompleta? questaoCompleta,
    @Default(Status.inicial) Status status,
    @Default('') String erroMessage,
  }) = _Initial;
}
