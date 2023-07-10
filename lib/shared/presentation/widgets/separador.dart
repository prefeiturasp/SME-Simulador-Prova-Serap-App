import 'package:flutter/material.dart';

class Separador extends StatelessWidget {
  const Separador({super.key, this.espacamento = 1});

  final double espacamento;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8 * espacamento,
    );
  }
}
