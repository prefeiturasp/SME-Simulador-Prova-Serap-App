import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/domain/failures/failure.codegen.dart';
import '../../../domain/entities/questao_completa_entity.dart';
import '../../../domain/usecases/obter_questao_completa.dart';

part 'questao_visualizar_state.dart';
part 'questao_visualizar_cubit.freezed.dart';

class QuestaoVisualizarCubit extends Cubit<QuestaoVisualizarState> {
  QuestaoVisualizarCubit(
    this._obterQuestaoCompletaUseCase,
  ) : super(QuestaoVisualizarState.inicial());

  final ObterQuestaoCompletaUseCase _obterQuestaoCompletaUseCase;

  carregarQuestaoCache(int cadernoId, int questaoId) async {
    emit(QuestaoVisualizarState.carregando());

    debugPrint('Carregando questao local: $cadernoId, questaoId: $questaoId');

    Either<Failure, QuestaoCompleta> result = await _obterQuestaoCompletaUseCase(
      Params(
        questaoId: questaoId,
        cadernoId: cadernoId,
      ),
    );

    result.fold((Failure l) {
      emit(QuestaoVisualizarState.erro(l.message));
    }, (QuestaoCompleta r) {
      emit(QuestaoVisualizarState.carregado(r));
    });
  }
}
