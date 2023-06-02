import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/features/auth/domain/usecases/autenticar_usecase.dart';
import 'package:serap_simulador/features/auth/presentation/cubits/auth/auth_cubit.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@singleton
class LoginCubit extends Cubit<LoginState> {
  final AuthCubit authCubit;
  final AutenticarUseCase autenticarUseCase;

  LoginCubit(
    this.authCubit,
    this.autenticarUseCase,
  ) : super(const LoginState.initial());

  // Fazer login
  void loginByCode(String? codigo) async {
    emit(state.copyWith(
      pageStatus: PageStatus.inicial,
    ));

    if (codigo == null || codigo.isEmpty) {
      emit(state.copyWith(
        pageStatus: PageStatus.emptyCodigo,
        exceptionError: "Erro ao obter codigo de autenticação",
      ));
      return;
    }

    try {
      emit(state.copyWith(pageStatus: PageStatus.carregando));

      var params = Params(
        codigo: codigo,
      );

      var result = await autenticarUseCase(params);

      result.fold(
        (l) => emit(state.copyWith(
          pageStatus: PageStatus.errorServer,
          exceptionError: l.message,
        )),
        (r) {
          emit(state.copyWith(
            pageStatus: PageStatus.sucesso,
          ));
        },
      );
    } on Exception catch (error) {
      emit(state.copyWith(
        exceptionError: "Erro: $error",
      ));
    }
  }
}
