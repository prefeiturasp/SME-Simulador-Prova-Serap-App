import 'package:flutter/material.dart';
import 'package:serap_simulador/core/utils/colors.dart';
import 'package:serap_simulador/shared/presentation/widgets/texto_default.widget.dart';

class BotaoDefaultWidget extends StatelessWidget {
  final String? textoBotao;
  final Widget? child;
  final double? largura;
  final bool desabilitado;
  final Function()? onPressed;

  BotaoDefaultWidget({
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
      child: TextButton(
        onPressed: desabilitado ? null : onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(desabilitado ? Colors.grey : TemaUtil.laranja01),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
      return Center(
        child: Texto(
          textoBotao!,
          center: true,
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          maxLines: 2,
        ),
      );
    }

    return child;
  }
}
