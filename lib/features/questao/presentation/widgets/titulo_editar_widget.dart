import 'package:flutter/material.dart';
import 'package:serap_simulador/shared/presentation/widgets/separador.dart';

class TituloEditarWidget extends StatelessWidget {
  const TituloEditarWidget(
    this.titulo, {
    super.key,
  });

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        Separador(),
      ],
    );
  }
}
