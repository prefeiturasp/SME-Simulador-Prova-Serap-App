import 'package:dartz/dartz.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';

import '../entities/prova_questao_entity.dart';
import '../entities/questao_completa_entity.dart';
import '../entities/questao_completa_salvar_entity.dart';

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

  Future<Either<Failure, bool>> salvarAlteracao({
    required QuestaoCompletaSalvar questaoCompleta,
  });

  Future<Either<Failure, List<ProvaQuestao>>> getProvasPorQuestao({
    required int questaoId,
  });
}
