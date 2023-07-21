import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_url_entity.dart';

part 'arquivo_upload_response_model.freezed.dart';
part 'arquivo_upload_response_model.g.dart';

@freezed
abstract class ArquivoUploadResponseModel with _$ArquivoUploadResponseModel {
  ArquivoUploadResponseModel._();

  factory ArquivoUploadResponseModel({
    required bool success,
    required int? type,
    required String message,
    required String fileLink,
    required int idFile,
  }) = _ArquivoUploadResponseModel;
  factory ArquivoUploadResponseModel.fromJson(Map<String, dynamic> json) => _$ArquivoUploadResponseModelFromJson(json);

  ArquivoUrl toModel() {
    return ArquivoUrl(
      success: success,
      type: type,
      message: message,
      fileLink: fileLink,
      idFile: idFile,
    );
  }
}
