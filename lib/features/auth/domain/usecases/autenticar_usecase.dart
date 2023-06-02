import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/features/auth/domain/entities/autenticacao.dart';
import 'package:serap_simulador/features/auth/domain/repositories/i_authentication_repository.dart';

@Singleton()
class AutenticarUseCase implements IUseCase<Autenticacao, Params> {
  final IAutenticacaoRepository repository;

  AutenticarUseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, Autenticacao>> call(Params params) async {
    var result = await repository.loginByCodigoAutenticacao(params.codigo);
    return result;
  }
}

class Params extends Equatable {
  final String codigo;

  const Params({
    required this.codigo,
  });

  @override
  List<Object> get props => [codigo];
}
