import 'package:flutter/material.dart';
import 'package:serap_simulador/core/utils/colors.dart';
import 'package:serap_simulador/shared/presentation/widgets/texto_default.widget.dart';

class BotaoTercearioWidget extends StatelessWidget {
  final String? textoBotao;
  final Widget? child;
  final double? largura;
  final bool desabilitado;
  final Function()? onPressed;

  BotaoTercearioWidget({
    super.key,
    this.textoBotao,
    this.largura,
    this.onPressed,
    this.child,
    this.desabilitado = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: largura,
      constraints: BoxConstraints(minHeight: 40),
      child: OutlinedButton(
        onPressed: desabilitado ? null : onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: TemaUtil.azul02, width: 1.0, style: BorderStyle.solid),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        child: Center(
          child: _buildChild(),
        ),
      ),
    );
  }

  _buildChild() {
    if (textoBotao != null) {
      return Texto(
        textoBotao!,
        center: true,
        color: TemaUtil.azul02,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        maxLines: 2,
      );
    }

    return child;
  }
}
