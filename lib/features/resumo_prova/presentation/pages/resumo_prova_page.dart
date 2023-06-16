// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/core/extensions/string_extensions.dart';
import 'package:serap_simulador/features/resumo_prova/domain/entities/prova_resumo.dart';
import 'package:serap_simulador/features/resumo_prova/presentation/cubits/prova_resumo/prova_resumo_cubit.dart';
import 'package:serap_simulador/gen/assets.gen.dart';
import 'package:serap_simulador/shared/presentation/widgets/cabecalho.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/utils/colors.dart';

@RoutePage()
class ResumoProvaPage extends StatefulHookWidget {
  const ResumoProvaPage({
    super.key,
    @PathParam('cadernoId') required this.cadernoId,
  });

  final int cadernoId;

  @override
  State createState() => _ResumoProvaPageState();
}

class _ResumoProvaPageState extends State<ResumoProvaPage> {
  @override
  Widget build(BuildContext context) {
    final eventoDetalhesCubit = BlocProvider.of<ProvaResumoCubit>(context);

    useEffect(() {
      eventoDetalhesCubit.carregarResumo(widget.cadernoId);

      return null;
    }, const []);

    return Scaffold(
      appBar: Cabecalho('Listagem de Prova'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Padding(
            padding: getPadding(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Resumo da Prova',
                    style: TextStyle(
                      color: TemaUtil.preto,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<ProvaResumoCubit, ProvaResumoState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        carregando: () {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        carregado: (provaResumo) {
                          return Column(
                            children: [
                              _buildCabecalho(),
                              _divider(),
                              ..._buildListaRespostas(provaResumo),
                            ],
                          );
                        },
                        orElse: () => SizedBox.shrink(),
                      );
                    },
                  ),
                ],
              ),
            ),
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

  _buildCabecalho() {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Text(
            "Questão",
            style: TextStyle(fontSize: 14, color: TemaUtil.appBar),
          ),
        ),
        Flexible(
          flex: 3,
          child: Center(
            child: Text(
              "Visualizar item",
              style: TextStyle(fontSize: 14, color: TemaUtil.appBar),
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey,
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey,
        ),
        Container(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  List<Widget> _buildListaRespostas(List<ProvaResumo> items) {
    List<Widget> questoes = [];

    for (var item in items) {
      questoes.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: _buildResumo(item),
        ),
      );
      questoes.add(_divider());
    }

    return questoes;
  }

  Widget _buildResumo(ProvaResumo questaoResumo) {
    String ordemQuestaoTratada =
        questaoResumo.ordem < 10 ? '0${questaoResumo.ordem + 1}' : '${questaoResumo.ordem + 1}';

    String titulo = ordemQuestaoTratada +
        " - " +
        (questaoResumo.titulo?.tratarTexto() ?? "") +
        (questaoResumo.descricao?.tratarTexto() ?? "");

    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Text(
            titulo,
            maxLines: 1,
            style: TextStyle(fontSize: 14),
          ),
        ),
        Flexible(
          flex: 3,
          child: Center(
            child: _buildVisualizar(questaoResumo.ordem, questaoResumo.id),
          ),
        )
      ],
    );
  }

  _buildVisualizar(int questaoOrdem, int questaoId) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      onTap: () {
        // context.router.push(
        //   "/prova/caderno/${widget.cadernoId}/questao/$questaoId",
        // );
      },
      child: Assets.icons.iconeRevisao.svg(),
    );
  }
}
