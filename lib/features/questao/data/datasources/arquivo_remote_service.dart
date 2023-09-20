import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:serap_simulador/features/questao/data/models/arquivo_upload_response_model.dart';

part 'arquivo_remote_service.g.dart';

@RestApi()
@Singleton()
abstract class ArquivoRemoteService {
  @factoryMethod
  factory ArquivoRemoteService(Dio dio) = _ArquivoRemoteService;

  @POST('file/upload')
  Future<HttpResponse<ArquivoUploadResponseModel>> uploadArquivo({
    @Field() required int contentLength,
    @Field() required String contentType,
    @Field() required String fileName,
    @Field() required String inputStream,
    @Field() required int fileType,
  });
}
