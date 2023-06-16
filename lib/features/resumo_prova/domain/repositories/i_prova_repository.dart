import 'package:dartz/dartz.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/features/resumo_prova/domain/entities/prova_resumo.dart';

abstract class IProvaRepository {
  Future<Either<Failure, List<ProvaResumo>>> obterResumoByCaderno(int cadernoId);
}
