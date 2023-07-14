import 'package:equatable/equatable.dart';

class AlternativaSalvar extends Equatable {
  final int id;
  final String descricao;

  AlternativaSalvar({
    required this.id,
    required this.descricao,
  });

  @override
  List<Object> get props => [id, descricao];
}
