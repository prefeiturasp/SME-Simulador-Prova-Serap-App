import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/prova_questao_entity.dart';
import '../../../domain/usecases/obter_provas_da_questao.dart';

part 'questao_provas_state.dart';
part 'questao_provas_cubit.freezed.dart';

@Singleton()
class QuestaoProvasCubit extends Cubit<QuestaoProvasState> {
  QuestaoProvasCubit(this._obterProvasDaQuestaoUseCase) : super(QuestaoProvasState.inicial());

  final ObterProvasDaQuestaoUseCase _obterProvasDaQuestaoUseCase;

  carregarProvas(int questaoId) async {
    emit(state.copyWith(status: Status.carregando));

    var result = await _obterProvasDaQuestaoUseCase.call(Params(questaoId: questaoId));

    result.fold(
      (l) {
        emit(state.copyWith(
          status: Status.erro,
          errorMessage: l.toString(),
          provasMarcadas: [],
        ));
      },
      (r) {
        emit(state.copyWith(
          status: Status.carregado,
          data: r,
          provasMarcadas: r.map((e) => '${e.id}-${e.questaoId}').toList(),
        ));
      },
    );
  }

  void adicionarProva(int provaId, int questaoId) {
    List<String> provasMarcadas = List.of(state.provasMarcadas);
    provasMarcadas.add('$provaId-$questaoId');

    emit(state.copyWith(provasMarcadas: provasMarcadas));
  }

  void removeProva(int provaId, int questaoId) {
    List<String> provasMarcadas = List.of(state.provasMarcadas);
    provasMarcadas.remove('$provaId-$questaoId');

    emit(state.copyWith(provasMarcadas: provasMarcadas));
  }
}
