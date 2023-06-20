part of 'prova_resumo_cubit.dart';

@freezed
class ProvaResumoState with _$ProvaResumoState {
  const factory ProvaResumoState.inicial() = _Inicial;
  const factory ProvaResumoState.carregando() = _Carregando;
  const factory ProvaResumoState.carregado(List<ProvaResumo> provaResumo) = _Carregado;
  const factory ProvaResumoState.erro(String erro) = _Error;
}
