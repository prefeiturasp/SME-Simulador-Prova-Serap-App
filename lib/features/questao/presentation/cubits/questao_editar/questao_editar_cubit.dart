import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/features/questao/domain/entities/alternativa_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/prova_questao_salvar_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_entity.dart';
import 'package:serap_simulador/features/questao/domain/usecases/obter_questao_completa_local.dart';
import 'package:serap_simulador/features/questao/domain/usecases/salvar_questao_completa_local.dart';

import '../../../domain/usecases/salvar_alteracoes_usecase.dart';

part 'questao_editar_state.dart';
part 'questao_editar_cubit.freezed.dart';

enum TipoAlteracao {
  texto_base,
  enunciado,
  alternativa,
}

@Singleton()
class QuestaoEditarCubit extends Cubit<QuestaoEditarState> {
  QuestaoEditarCubit(
    this._obterQuestaoCompletaLocalUseCase,
    this._salvarQuestaoCompletaLocal,
    this._salvarAlteracoesUseCase,
  ) : super(QuestaoEditarState());

  final ObterQuestaoCompletaLocal _obterQuestaoCompletaLocalUseCase;
  final SalvarQuestaoCompletaLocal _salvarQuestaoCompletaLocal;
  final SalvarAlteracoesUseCase _salvarAlteracoesUseCase;

  carregarQuestao(int cadernoId, int questaoId) async {
    emit(state.copyWith(status: Status.carregando));

    var result = await _obterQuestaoCompletaLocalUseCase(Params(cadernoId: cadernoId, questaoId: questaoId));

    result.fold((f) {
      emit(state.copyWith(
        status: Status.erro,
        erroMessage: f.toString(),
      ));
    }, (r) {
      emit(state.copyWith(
        status: Status.carregado,
        questaoCompleta: r,
      ));
    });
  }

  changeTextoBase(String textoBase) {
    QuestaoCompleta questaoCompleta = state.questaoCompleta!;

    Questao questao = questaoCompleta.questao.copyWith(textoBase: textoBase);

    emit(state.copyWith(questaoCompleta: questaoCompleta.copyWith(questao: questao)));
  }

  changeEnunciado(String enunciado) {
    QuestaoCompleta questaoCompleta = state.questaoCompleta!;

    Questao questao = questaoCompleta.questao.copyWith(enunciado: enunciado);

    emit(state.copyWith(questaoCompleta: questaoCompleta.copyWith(questao: questao)));
  }

  changeAlternativa(int ordem, String? descricao) {
    QuestaoCompleta questaoCompleta = state.questaoCompleta!;

    List<Alternativa> novaAlternativas = [];

    for (var alternativa in questaoCompleta.alternativas) {
      if (alternativa.ordem == ordem) {
        novaAlternativas.add(alternativa.copyWith(descricao: descricao ?? ''));
      } else {
        novaAlternativas.add(alternativa);
      }
    }

    var novaQuestaoCompleta = questaoCompleta.copyWith(alternativas: novaAlternativas);

    emit(state.copyWith(questaoCompleta: novaQuestaoCompleta));
  }

  salvarQuestaoLocal() async {
    await _salvarQuestaoCompletaLocal.call(
      ParamsSalvarQuestaoCompleta(questaoCompleta: state.questaoCompleta!),
    );
  }

  void setQuestaoCompleta(QuestaoCompleta questaoCompleta) {
    emit(state.copyWith(questaoCompleta: questaoCompleta));
  }

  salvarQuestao(List<String> provasQuestao) async {
    if (provasQuestao.isEmpty) {
      return;
    }

    var response = await _salvarAlteracoesUseCase.call(
      ParamsSalvarAlteracoes(
        provasQuestoes: provasQuestao.map((e) {
          var data = e.split('-');

          return ProvaQuestaoSalvar(
            provaId: int.parse(data[0]),
            questaoId: int.parse(data[1]),
          );
        }).toList(),
        questaoCompleta: state.questaoCompleta!,
      ),
    );

    if (response.getOrElse(() => false)) {
      emit(state.copyWith(status: Status.salvo));
    }
  }
}
