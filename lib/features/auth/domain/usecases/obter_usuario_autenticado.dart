import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/usecases/use_case.dart';
import 'package:serap_simulador/core/extensions/dartz_extensions.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/features/auth/domain/entities/autenticacao.dart';
import 'package:serap_simulador/features/auth/domain/repositories/i_authentication_repository.dart';

@injectable
class ObterUsuarioAutenticadoUseCase implements IUseCaseOption<Autenticacao?, NoParams> {
  final IAutenticacaoRepository repository;

  ObterUsuarioAutenticadoUseCase(
    this.repository,
  );

  @override
  Future<Option<Autenticacao?>> call(NoParams params) async {
    var result = await repository.getUsuarioAutenticado();
    return optionOf(result.getRight());
  }
}
