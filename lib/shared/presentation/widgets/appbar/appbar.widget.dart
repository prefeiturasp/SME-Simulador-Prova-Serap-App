import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';
import 'package:serap_simulador/core/utils/colors.dart';
import 'package:serap_simulador/features/auth/data/datasources/autenticacao_local_datasource.dart';
import 'package:serap_simulador/injector.dart';

import '../dialog/dialogs.dart';
import '../texto_default.widget.dart';

class AppBarWidget extends StatelessWidget {
  final bool popView;
  final bool exibirSair;
  final String? subtitulo;
  final bool mostrarBotaoVoltar;
  final Widget? leading;

  AppBarWidget({
    super.key,
    required this.popView,
    this.subtitulo,
    this.mostrarBotaoVoltar = false,
    this.exibirSair = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return _buildAppbarCompleta(context);
  }

  Widget _buildAppbarCompleta(BuildContext context) {
    return AppBar(
      title: Observer(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Texto(
                  "{_principalStore.usuario.nome} ({_principalStore.usuario.codigoEOL})",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Texto(
                "",
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildSubtitulo(),
              ),
            ],
          );
        },
      ),
      automaticallyImplyLeading: false,
      leading: leading ?? (mostrarBotaoVoltar ? _buildBotaoVoltarLeading(context) : null),
      actions: [
        _buildAlterarFonte(context),
        exibirSair ? _buildBotaoSair(context) : Container(),
      ],
    );
  }

  Widget? _buildBotaoVoltarLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () async {
        context.router.pop();
      },
    );
  }

  _buildSubtitulo() {
    if (subtitulo != null) {
      return Text(
        subtitulo!,
        style: TextStyle(
          fontSize: 12,
        ),
      );
    }

    return SizedBox(
      height: 0,
    );
  }

  _buildBotaoSair(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(TemaUtil.appBar),
      ),
      child: Icon(Icons.exit_to_app_outlined, color: TemaUtil.laranja02),
      onPressed: () async {
        bool sair = true;

        if (!kIsWeb) {
          sair = (await mostrarDialogSairSistema(context)) ?? false;
        }

        if (sair) {
          await sl<IAutenticacaoLocalDataSource>().apagarToken();
          context.replaceRoute(LoginRoute());
        }
      },
    );
  }

  _buildAlterarFonte(BuildContext context) {
    return SizedBox.shrink();
  }
}
