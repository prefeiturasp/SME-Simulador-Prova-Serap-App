import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/features/resumo_prova/domain/entities/prova_resumo.dart';
import 'package:serap_simulador/features/resumo_prova/domain/usecases/obter_resumo_prova_usecase.dart';

part 'prova_resumo_state.dart';
part 'prova_resumo_cubit.freezed.dart';

@Singleton()
class ProvaResumoCubit extends Cubit<ProvaResumoState> {
  final ObterResumoProvaUseCase obterResumoProvaUseCase;

  ProvaResumoCubit(this.obterResumoProvaUseCase) : super(ProvaResumoState.inicial());

  void carregarResumo(int cadernoId) async {
    emit(ProvaResumoState.carregando());

    debugPrint('Carregando prova');

    var result = await obterResumoProvaUseCase(Params(
      cadernoId: cadernoId,
    ));

    result.fold(
      (Failure l) {
        emit(ProvaResumoState.erro(l.message));
      },
      (List<ProvaResumo> r) {
        emit(ProvaResumoState.carregado(r));
      },
    );
  }
}
