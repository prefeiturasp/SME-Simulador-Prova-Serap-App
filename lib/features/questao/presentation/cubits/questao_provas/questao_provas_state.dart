part of 'questao_provas_cubit.dart';

enum Status { inicial, carregando, carregado, erro }

@freezed
class QuestaoProvasState with _$QuestaoProvasState {
  factory QuestaoProvasState.inicial({
    @Default(Status.inicial) Status status,
    List<ProvaQuestao>? data,
    @Default([]) List<String> provasMarcadas,
    @Default('') String errorMessage,
    @Default(true) bool podeSalvar,
  }) = _Inicial;
}

