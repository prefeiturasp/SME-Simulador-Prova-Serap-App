import 'package:equatable/equatable.dart';

class AlternativaBean extends Equatable {
  final int id;
  final String descricao;

  AlternativaBean(
    this.id,
    this.descricao,
  );

  @override
  List<Object> get props => [id, descricao];
}
