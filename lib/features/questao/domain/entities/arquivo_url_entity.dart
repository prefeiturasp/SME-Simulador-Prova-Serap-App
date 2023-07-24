import 'package:equatable/equatable.dart';

class ArquivoUrl extends Equatable {
  final bool success;
  final int? type;
  final String message;
  final String fileLink;
  final int idFile;

  ArquivoUrl({
    required this.success,
    required this.type,
    required this.message,
    required this.fileLink,
    required this.idFile,
  });

  @override
  List<Object> get props => [idFile, success, fileLink];
}
