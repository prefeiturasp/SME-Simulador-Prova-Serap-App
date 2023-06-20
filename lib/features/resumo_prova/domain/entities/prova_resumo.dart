import 'package:equatable/equatable.dart';

class ProvaResumo extends Equatable {
  final int id;
  final String? titulo;
  final String? descricao;
  final String caderno;
  final int ordem;

  final int idProva;
  final String descricaoProva;

  ProvaResumo({
    required this.id,
    required this.caderno,
    required this.ordem,
    this.titulo,
    this.descricao,
    required this.idProva,
    required this.descricaoProva,
  });

  @override
  List<Object> get props => [id, caderno, ordem];
}
