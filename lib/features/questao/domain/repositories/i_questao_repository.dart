import 'package:dartz/dartz.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';

abstract class IQuestaoRepository {
  Future<Either<Failure, QuestaoCompleta>> getQuestaoCompleta({
    required int questaoId,
    required int cadernoId,
  });

  Future<Either<Failure, QuestaoCompleta>> getQuestaoCompletaLocal({
    required int questaoId,
    required int cadernoId,
  });

  Future<Either<Failure, bool>> salvarQuestaoCompletaLocal({
    required QuestaoCompleta questaoCompleta,
  });
}
