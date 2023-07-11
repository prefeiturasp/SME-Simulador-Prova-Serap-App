import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/core/domain/failures/failure.codegen.dart';
import 'package:serap_simulador/core/interfaces/i_usecase.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/domain/repositories/i_questao_repository.dart';

@Singleton()
class ObterQuestaoCompletaUseCase implements IUseCase<QuestaoCompleta, Params> {
  final IQuestaoRepository repository;

  ObterQuestaoCompletaUseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, QuestaoCompleta>> call(Params params) async {
    var result = await repository.getQuestaoCompleta(
      questaoId: params.questaoId,
      cadernoId: params.cadernoId,
    );
    return result;
  }
}

class Params extends Equatable {
  final int questaoId;
  final int cadernoId;

  const Params({
    required this.questaoId,
    required this.cadernoId,
  });

  @override
  List<Object> get props => [questaoId, cadernoId];
}
