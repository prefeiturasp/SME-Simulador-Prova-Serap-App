import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';
import 'package:serap_simulador/core/utils/colors.dart';
import 'package:serap_simulador/features/questao/domain/entities/alternativa_entity.dart';
import 'package:serap_simulador/features/questao/presentation/cubits/questao/questao_cubit.dart';
import 'package:serap_simulador/features/questao/presentation/cubits/questao_editar/questao_editar_cubit.dart';
import 'package:serap_simulador/shared/presentation/widgets/cabecalho.dart';
import 'package:serap_simulador/shared/presentation/widgets/separador.dart';

import '../widgets/editor_html_enhanced.dart';
import '../widgets/titulo_editar_widget.dart';

@RoutePage()
class QuestaoEditarPage extends StatefulWidget {
  final int cadernoId;
  final int questaoId;

  QuestaoEditarPage({
    super.key,
    @PathParam('cadernoId') required this.cadernoId,
    @PathParam('questaoId') required this.questaoId,
  });

  @override
  State<QuestaoEditarPage> createState() => _QuestaoEditarPageState();
}

class _QuestaoEditarPageState extends State<QuestaoEditarPage> {
  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      context.read<QuestaoEditarCubit>().carregarQuestao(widget.cadernoId, widget.questaoId);
    });
  }

  Widget? _buildBotaoVoltarLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () async {
        context.router.replace(
          ResumoCadernoProvaRoute(
            key: Key('${widget.cadernoId}'),
            cadernoId: widget.cadernoId,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Cabecalho(
          leading: _buildBotaoVoltarLeading(context),
          mostrarBotaoSair: false,
          actions: [
            _buildBotaoAplicar(widget.cadernoId, widget.questaoId),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<QuestaoCubit, QuestaoState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    carregando: () {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    carregado: (questaoCompleta) {
                      context.read<QuestaoEditarCubit>().setQuestaoCompleta(questaoCompleta);

                      var questao = questaoCompleta.questao;
                      var alternativas = questaoCompleta.alternativas;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Questao ${questao.ordem + 1}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Separador(espacamento: 2),

                          // Titulo
                          _buildEditor(
                            titulo: 'Texto base',
                            content: questao.textoBase,
                            onTextChanged: (text) {
                              context.read<QuestaoEditarCubit>().changeTextoBase(text ?? '');
                            },
                          ),

                          Separador(espacamento: 3),

                          // Descricao
                          _buildEditor(
                            titulo: 'Enunciado',
                            content: questao.enunciado,
                            onTextChanged: (text) {
                              context.read<QuestaoEditarCubit>().changeEnunciado(text ?? '');
                            },
                          ),

                          Separador(espacamento: 3),

                          // Alternativas
                          _buildEditorAlternativas(alternativas),

                          Separador(espacamento: 3),
                        ],
                      );
                    },
                    orElse: () => SizedBox.shrink(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditor({required String titulo, String? content, required Function(String? text) onTextChanged}) {
    return _buildExpansionTile(
      titulo: titulo,
      children: [
        EditorHtmlEnhanced(
          text: content ?? '',
          onTextChanged: onTextChanged,
        ),
      ],
    );
  }

  _buildExpansionTile({required String titulo, required List<Widget> children}) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        collapsedIconColor: TemaUtil.preto01,
        collapsedBackgroundColor: TemaUtil.branco,
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: TituloEditarWidget(titulo),
        backgroundColor: TemaUtil.branco,
        iconColor: TemaUtil.preto01,
        textColor: TemaUtil.preto01,
        childrenPadding: EdgeInsets.all(8),
        children: children,
      ),
    );
  }

  Widget _buildEditorAlternativas(List<Alternativa> alternativas) {
    return _buildExpansionTile(
      titulo: 'Alternativas',
      children: [
        ...alternativas.map((e) => _buildEditorAlternativa(e)),
      ],
    );
  }

  _buildEditorAlternativa(Alternativa alternativa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Separador(
          espacamento: 2,
        ),
        TituloEditarWidget(alternativa.numeracao),
        EditorHtmlEnhanced(
          height: 100,
          text: alternativa.descricao,
          onTextChanged: (text) {
            context.read<QuestaoEditarCubit>().changeAlternativa(alternativa.ordem, text);
          },
        ),
      ],
    );
  }

  Widget _buildBotaoAplicar(int cadernoId, int questaoId) {
    return InkWell(
      onTap: () {
        context.read<QuestaoEditarCubit>().salvarQuestaoLocal();

        context.router.push(
          QuestaoEditarPreviewRoute(
            cadernoId: cadernoId,
            questaoId: questaoId,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text('Aplicar'),
        ),
      ),
    );
  }
}
