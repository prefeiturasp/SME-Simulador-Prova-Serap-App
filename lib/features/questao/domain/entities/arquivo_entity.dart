// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Arquivo extends Equatable {
  final int id;

  final String caminho;
  final String? base64;

  Arquivo({
    required this.id,
    required this.caminho,
    this.base64,
  });

  @override
  List<Object> get props => [id, caminho];
}
