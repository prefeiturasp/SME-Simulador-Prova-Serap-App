import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:serap_simulador/features/auth/domain/entities/autenticacao.dart';

part 'autenticacao.model.freezed.dart';
part 'autenticacao.model.g.dart';

@freezed
class AutenticacaoModel with _$AutenticacaoModel {
  const AutenticacaoModel._();

  factory AutenticacaoModel({
    required String token,
    required DateTime dataHoraExpiracao,
    DateTime? ultimoLogin,
  }) = _AutenticacaoModel;

  factory AutenticacaoModel.fromJson(Map<String, dynamic> json) => _$AutenticacaoModelFromJson(json);

  Autenticacao toDomain() {
    var tokenParsed = Jwt.parseJwt(token);

    return Autenticacao(
      token: token,
      dataHoraExpiracao: dataHoraExpiracao,
      ultimoLogin: ultimoLogin,
      login: tokenParsed['LOGIN'],
      nome: tokenParsed['NOME'],
      perfil: tokenParsed['PERFIL'],
    );
  }
}
