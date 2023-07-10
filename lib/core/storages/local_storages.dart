import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:serap_simulador/features/questao/data/models/questao_completa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String accessToken);
  Future<bool> deleteAccessToken();

  Future<String?> getRefreshToken();
  Future<void> saveRefreshToken(String refreshToken);
  Future<bool> deleteRefreshToken();

  Future<void> removeTokens();

  Future<bool> saveCadernoId(int cadernoId);
  Future<int?> getCadernoId();

  Future<bool> saveQuestaoCompleta(QuestaoCompletaModel questaoCompletaModel);
  Future<QuestaoCompletaModel?> getQuestaoCompleta(int questaoId);
}

@Singleton(as: LocalStorage)
class LocalStorageImpl implements LocalStorage {
  const LocalStorageImpl(this._storage);
  final SharedPreferences _storage;
  static const _apiAccessToken = 'accessToken';
  static const _apiRefreshToken = 'refreshToken';
  static const _cadernoId = 'cadernoId';

  @override
  Future<String?> getAccessToken() {
    return Future.value(
      _storage.getString(_apiAccessToken),
    );
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    await Future.value(
      _storage.setString(_apiAccessToken, accessToken),
    );
  }

  @override
  Future<String?> getRefreshToken() {
    return Future.value(
      _storage.getString(_apiRefreshToken),
    );
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await Future.value(
      _storage.setString(_apiRefreshToken, refreshToken),
    );
  }

  @override
  Future<bool> deleteAccessToken() async {
    return await _storage.remove(_apiAccessToken);
  }

  @override
  Future<bool> deleteRefreshToken() async {
    return await _storage.remove(_apiRefreshToken);
  }

  @override
  Future<void> removeTokens() async {
    await deleteAccessToken();
    await deleteRefreshToken();
  }

  @override
  Future<int?> getCadernoId() async {
    return Future.value(
      _storage.getInt(_cadernoId),
    );
  }

  @override
  Future<bool> saveCadernoId(int cadernoId) async {
    return await Future.value(
      _storage.setInt(_cadernoId, cadernoId),
    );
  }

  @override
  Future<QuestaoCompletaModel?> getQuestaoCompleta(int questaoId) async {
    String? questaoString = _storage.getString(questaoId.toString());

    if (questaoString != null) {
      return Future.value(
        QuestaoCompletaModel.fromJson(jsonDecode(questaoString)),
      );
    }

    return null;
  }

  @override
  Future<bool> saveQuestaoCompleta(QuestaoCompletaModel questaoCompletaModel) async {
    return await Future.value(
      _storage.setString(questaoCompletaModel.id.toString(), jsonEncode(questaoCompletaModel.toJson())),
    );
  }
}
