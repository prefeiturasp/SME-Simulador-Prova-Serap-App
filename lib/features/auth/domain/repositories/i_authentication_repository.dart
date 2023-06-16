import 'package:dartz/dartz.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/features/auth/domain/entities/autenticacao.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class IAutenticacaoRepository {
  Stream<AuthenticationStatus> get status;

  Future<Either<Failure, Autenticacao>> loginByCodigoAutenticacao(String codigo);
  Future<Either<Failure, Autenticacao?>> getUsuarioAutenticado();
  Future<Either<Failure, Unit>> revalidar( String token);
  Future<void> dispose();
}
