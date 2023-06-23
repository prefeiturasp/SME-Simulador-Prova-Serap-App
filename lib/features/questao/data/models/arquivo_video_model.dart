import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_video_entity.dart';

part 'arquivo_video_model.freezed.dart';
part 'arquivo_video_model.g.dart';

@freezed
abstract class ArquivoVideoModel with _$ArquivoVideoModel {
  ArquivoVideoModel._();

  factory ArquivoVideoModel({
    @JsonKey(name: 'videoId') required int id,
    required String caminhoVideo,
    required String caminhoThumbnailVideo,
    String? caminhoVideoConvertido,
  }) = _ArquivoVideoModel;
  factory ArquivoVideoModel.fromJson(Map<String, dynamic> json) => _$ArquivoVideoModelFromJson(json);

  ArquivoVideo toModel() {
    return ArquivoVideo(
      id: id,
      path: caminhoVideo,
    );
  }
}
