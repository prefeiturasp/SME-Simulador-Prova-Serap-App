import 'package:equatable/equatable.dart';

class ProvaResumo extends Equatable {
  final int id;
  final String? titulo;
  final String? descricao;
  final String caderno;
  final int ordem;

  ProvaResumo({
    required this.id,
    required this.caderno,
    required this.ordem,
    this.titulo,
    this.descricao,
  });

  @override
  List<Object> get props => [id, caderno, ordem];
}
