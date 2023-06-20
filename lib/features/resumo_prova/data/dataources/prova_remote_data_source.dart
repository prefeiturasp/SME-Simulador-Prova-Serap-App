// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:serap_simulador/app/network/dio_client.dart';

import '../models/prova_resumo.model.dart';
import 'prova_remote_service.dart';

abstract class IProvaRemoteDataSource {
  Future<List<ProvaResumoModel>> getResumoByCaderno({required int cadernoId});
}

@Injectable(as: IProvaRemoteDataSource)
class ProvaRemoteDataSource implements IProvaRemoteDataSource {
  ProvaRemoteService provaRemoteService;

  ProvaRemoteDataSource(
    this.provaRemoteService,
  );

  @override
  Future<List<ProvaResumoModel>> getResumoByCaderno({required int cadernoId}) async {
    try {
      final response = await provaRemoteService.getResumoByCaderno(
        cadernoId: cadernoId,
      );

      return response.data;
    } on DioError catch (e) {
      throw handleNertorkError(e);
    }
  }
}
