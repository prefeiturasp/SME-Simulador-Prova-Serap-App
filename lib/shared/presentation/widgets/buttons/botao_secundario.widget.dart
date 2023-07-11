import 'package:flutter/material.dart';
import 'package:serap_simulador/core/utils/colors.dart';

class BotaoSecundarioWidget extends StatelessWidget {
  final String textoBotao;
  final double? largura;
  final Function()? onPressed;
  final Color corDoTexto;

  BotaoSecundarioWidget({
    super.key,
    required this.textoBotao,
    this.largura,
    this.onPressed,
    this.corDoTexto = TemaUtil.pretoSemFoco,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: onPressed,
      child: Container(
        width: largura,
        constraints: BoxConstraints(minHeight: 40),
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Center(
          child: Text(
            textoBotao,
            style: TextStyle(
              color: corDoTexto,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
