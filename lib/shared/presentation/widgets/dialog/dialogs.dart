import 'package:flutter/material.dart';
import 'package:serap_simulador/gen/assets.gen.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_default.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_secundario.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/texto_default.widget.dart';

import 'dialog_default.widget.dart';

Future<bool?> mostrarDialogSairSistema(BuildContext context) {
  String mensagemCorpo =
      "Atenção, se você sair do sistema as provas baixadas serão apagadas do seu dispositivo. Deseja realmente sair?";

  return showDialog(
    context: context,
    barrierColor: Colors.black87,
    builder: (context) {
      return DialogDefaultWidget(
        cabecalho: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Assets.icons.erro.svg(
            height: 55,
          ),
        ),
        corpo: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Texto(
            mensagemCorpo,
            textOverflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        botoes: [
          BotaoSecundarioWidget(
            textoBotao: "CANCELAR",
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          BotaoDefaultWidget(
            textoBotao: "SAIR",
            onPressed: () {
              Navigator.pop(context, true);
            },
          )
        ],
      );
    },
  );
}
