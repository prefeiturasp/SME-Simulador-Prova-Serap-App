part of 'questao_provas_cubit.dart';

enum Status { inicial, carregando, carregado, erro }

@freezed
class QuestaoProvasState with _$QuestaoProvasState {
  factory QuestaoProvasState.inicial({
    @Default(Status.inicial) Status status,
    List<ProvaQuestao>? data,
    @Default([]) List<int> provasMarcadas,
    @Default('') String errorMessage,
  }) = _Inicial;
}
