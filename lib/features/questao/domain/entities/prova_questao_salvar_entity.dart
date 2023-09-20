import 'package:equatable/equatable.dart';

class ProvaQuestaoSalvar extends Equatable {
  ProvaQuestaoSalvar({
    required this.provaId,
    required this.questaoId,
  });

  final int provaId;
  final int questaoId;

  @override
  List<Object?> get props => [provaId, questaoId];
}
