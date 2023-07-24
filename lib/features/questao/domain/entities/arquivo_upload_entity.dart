import 'package:equatable/equatable.dart';
import 'package:serap_simulador/shared/enums/file_type.enum.dart';

class ArquivoUpload extends Equatable {
  final int contentLength;
  final String contentType;
  final String fileName;
  final String inputStream;
  final EnumFileType fileType;

  ArquivoUpload({
    required this.contentLength,
    required this.contentType,
    required this.fileName,
    required this.inputStream,
    required this.fileType,
  });

  @override
  List<Object> get props => [contentLength, contentType, fileName, inputStream, fileType];
}
