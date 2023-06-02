import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serap_simulador/shared/presentation/widgets/cabecalho.dart';

import '../../../../core/utils/colors.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: getPadding(),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                'Resumo da Prova',
                style: TextStyle(
                  color: TemaUtil.preto,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPadding([EdgeInsets mobile = const EdgeInsets.all(16)]) {
    if (kIsWeb) {
      return EdgeInsets.symmetric(
        horizontal: (MediaQuery.of(context).size.width - 600 - (24 * 2)) / 2,
      );
    } else {
      return mobile;
    }
  }
}
