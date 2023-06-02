part of 'login_cubit.dart';

enum PageStatus {
  inicial,
  carregando,
  emptyCodigo,
  errorLogin,
  errorServer,
  sucesso;

  bool get isFailure {
    return this == PageStatus.emptyCodigo || this == PageStatus.errorLogin || this == PageStatus.errorServer;
  }

  bool get isLoading {
    return this == PageStatus.carregando;
  }
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial({
    @Default(PageStatus.inicial) PageStatus pageStatus,
    @Default('') String exceptionError,
  }) = _Initial;
}
