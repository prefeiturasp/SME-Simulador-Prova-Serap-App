// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Autenticacao extends Equatable {
  final String token;
  final DateTime dataHoraExpiracao;
  final DateTime? ultimoLogin;

  Autenticacao({
    required this.token,
    required this.dataHoraExpiracao,
    this.ultimoLogin,
  });

  @override
  List<Object?> get props => [token, dataHoraExpiracao];
}
