import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/domain/usecases/obter_questao_completa.dart';

part 'questao_state.dart';
part 'questao_cubit.freezed.dart';

@Singleton()
class QuestaoCubit extends Cubit<QuestaoState> {
  QuestaoCubit(this._obterQuestaoCompletaUseCase) : super(QuestaoState.inicial());

  final ObterQuestaoCompletaUseCase _obterQuestaoCompletaUseCase;

  carregarQuestaoCompleta(int cadernoId, int questaoId) async {
    emit(QuestaoState.carregando());

    debugPrint('Carregando questao caderno: $cadernoId, questaoId: $questaoId');

    Either<Failure, QuestaoCompleta> result = await _obterQuestaoCompletaUseCase(
      Params(
        questaoId: questaoId,
        cadernoId: cadernoId,
      ),
    );

    result.fold((Failure l) {
      emit(QuestaoState.erro(l.message));
    }, (QuestaoCompleta r) {
      emit(QuestaoState.carregado(r));
    });
  }

  carregarQuestaoCache(int cadernoId, int questaoId) async {
    emit(QuestaoState.carregando());

    debugPrint('Carregando questao local: $cadernoId, questaoId: $questaoId');

    Either<Failure, QuestaoCompleta> result = await _obterQuestaoCompletaUseCase(
      Params(
        questaoId: questaoId,
        cadernoId: cadernoId,
      ),
    );

    result.fold((Failure l) {
      emit(QuestaoState.erro(l.message));
    }, (QuestaoCompleta r) {
      emit(QuestaoState.carregado(r));
    });
  }
}
