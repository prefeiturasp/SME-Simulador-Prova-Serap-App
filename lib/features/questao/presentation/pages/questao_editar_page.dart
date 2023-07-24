import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../../../core/utils/colors.dart';
import '../../../../shared/enums/file_type.enum.dart';
import '../../../../shared/presentation/widgets/cabecalho.dart';
import '../../../../shared/presentation/widgets/separador.dart';
import '../../domain/entities/alternativa_entity.dart';
import '../cubits/questao_editar/questao_editar_cubit.dart';
import '../widgets/editor_html/editor_html.dart';
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
        if (context.router.canPop()) {
          context.router.pop();
        } else {
          context.router.replace(
            QuestaoRoute(
              key: Key('${widget.cadernoId}-${widget.questaoId}'),
              cadernoId: widget.cadernoId,
              questaoId: widget.questaoId,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(
        mostrarBotaoSair: false,
        leading: _buildBotaoVoltarLeading(context),
        actions: [
          _buildBotaoAplicar(widget.cadernoId, widget.questaoId),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<QuestaoEditarCubit, QuestaoEditarState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.carregando:
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    case Status.carregado:
                      var questao = state.questaoCompleta!.questao;
                      var alternativas = state.questaoCompleta!.alternativas;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Questão ${questao.ordem + 1}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Separador(espacamento: 2),

                          // Texto Base
                          _buildEditor(
                            fileType: EnumFileType.texto_base,
                            titulo: 'Texto base',
                            content: questao.textoBase,
                            onTextChanged: (text) {
                              context.read<QuestaoEditarCubit>().changeTextoBase(text ?? '');
                            },
                          ),

                          Separador(espacamento: 3),

                          // Enunciado
                          _buildEditor(
                            fileType: EnumFileType.enunciado,
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

                    default:
                      return SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditor({
    required EnumFileType fileType,
    required String titulo,
    String? content,
    required Function(String? text) onTextChanged,
  }) {
    return _buildExpansionTile(
      titulo: titulo,
      children: [
        EditorHtml(
          fileType: fileType,
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
        EditorHtml(
          fileType: EnumFileType.alternativa,
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
          child: Icon(
            Icons.save_as,
            size: 32,
          ),
        ),
      ),
    );
  }
}
