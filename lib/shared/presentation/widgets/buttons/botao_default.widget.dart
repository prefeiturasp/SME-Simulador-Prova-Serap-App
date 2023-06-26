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
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: TemaUtil.laranja01,
        ),
        width: largura,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Container(
          constraints: BoxConstraints(minHeight: 40),
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
