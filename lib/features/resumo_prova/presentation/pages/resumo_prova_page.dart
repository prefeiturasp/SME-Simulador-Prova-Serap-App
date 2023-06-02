import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:serap_simulador/shared/presentation/widgets/cabecalho.dart';

@RoutePage()
class ResumoProvaPage extends StatefulWidget {
  const ResumoProvaPage({super.key});

  @override
  State<ResumoProvaPage> createState() => _ResumoProvaPageState();
}

class _ResumoProvaPageState extends State<ResumoProvaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho('Listagem de Prova'),
      body: Container(),
    );
  }
}
