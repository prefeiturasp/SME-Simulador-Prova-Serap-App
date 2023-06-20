import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/usecases/use_case.dart';
import 'package:serap_simulador/features/auth/domain/usecases/obter_cadernoid_usecase.dart';
import 'package:serap_simulador/features/auth/domain/usecases/salvar_cadernoid_usecase.dart';

part 'cache_caderno_id_state.dart';
part 'cache_caderno_id_cubit.freezed.dart';

@singleton
class CacheCadernoIdCubit extends Cubit<CacheCadernoIdState> {
  CacheCadernoIdCubit(
    this.salvarCadernoIdUseCase,
    this.obterCadernoIdUseCase,
  ) : super(CacheCadernoIdState.initial());

  final SalvarCadernoIdUseCase salvarCadernoIdUseCase;
  final ObterCadernoIdUseCase obterCadernoIdUseCase;

  void salvarCadernoId(int cadernoId) async {
    await salvarCadernoIdUseCase(Params(cadernoId: cadernoId));
  }

  Future<int?> obterCadernoId() async {
    var result = await obterCadernoIdUseCase(NoParams());

    return result.getOrElse(() => null);
  }
}
