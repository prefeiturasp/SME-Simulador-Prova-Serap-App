import 'package:equatable/equatable.dart';

class ArquivoVideo extends Equatable {
  final int id;
  final String path;

  ArquivoVideo({
    required this.id,
    required this.path,
  });

  @override
  List<Object> get props => [id, path];
}
