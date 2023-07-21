import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/features/questao/presentation/cubits/questao_provas/questao_provas_cubit.dart';
import 'package:serap_simulador/gen/assets.gen.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_default.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_secundario.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/separador.dart';
import 'package:serap_simulador/shared/presentation/widgets/texto_default.widget.dart';

import 'dialog_default.widget.dart';

Future<bool?> mostrarDialogSairSistema(BuildContext context) {
  String mensagemCorpo =
      "Atenção, se você sair do sistema as provas baixadas serão apagadas do seu dispositivo. Deseja realmente sair?";

  return showDialog(
    context: context,
    barrierColor: Colors.black87,
    builder: (context) {
      return DialogDefaultWidget(
        cabecalho: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Assets.icons.erro.svg(
            height: 55,
          ),
        ),
        corpo: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Texto(
            mensagemCorpo,
            textOverflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        botoes: [
          BotaoSecundarioWidget(
            textoBotao: "CANCELAR",
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          BotaoDefaultWidget(
            textoBotao: "SAIR",
            onPressed: () {
              Navigator.pop(context, true);
            },
          )
        ],
      );
    },
  );
}

Future<List<int>?> mostrarDialogSelecaoProva(BuildContext context, int questaoId) {
  String titulo = 'Nova versão do item';
  String mensagemCorpo1 = "Este item está cadastrado em algumas provas não iniciadas.";
  String mensagemCorpo2 = "Selecione em quais  provas deseja alterar o item para esta nova versão:";

  context.read<QuestaoProvasCubit>().carregarProvas(questaoId);

  return showDialog(
    context: context,
    barrierColor: Colors.black87,
    builder: (context) {
      return DialogDefaultWidget(
        corpo: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Texto(
                titulo,
                textOverflow: TextOverflow.visible,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              Texto(
                mensagemCorpo1,
                textOverflow: TextOverflow.visible,
                fontSize: 14,
              ),
              Texto(
                mensagemCorpo2,
                textOverflow: TextOverflow.visible,
                fontSize: 14,
              ),
              Separador(
                espacamento: 1,
              ),
              BlocBuilder<QuestaoProvasCubit, QuestaoProvasState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.carregando:
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    case Status.carregado:
                      return SelectionArea(
                        child: Column(
                          children: [
                            ...state.data!
                                .map((e) => CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                      value: state.provasMarcadas.contains(e.id),
                                      onChanged: (value) {
                                        if (value != null && value) {
                                          context.read<QuestaoProvasCubit>().adicionarProva(e.id);
                                        } else {
                                          context.read<QuestaoProvasCubit>().removeProva(e.id);
                                        }
                                      },
                                      title: Text(
                                        e.descricao,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text('ID: ${e.id} / ${e.componenteCurricular}'),
                                      secondary: Text('Versão: ${e.versao}'),
                                    ))
                                .toList()
                          ],
                        ),
                      );

                    case Status.erro:
                      return Text(state.errorMessage);

                    default:
                      return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
        botoes: [
          BotaoSecundarioWidget(
            textoBotao: 'Cancelar',
            onPressed: () async {
              Navigator.pop(context, null);
            },
          ),
          BlocBuilder<QuestaoProvasCubit, QuestaoProvasState>(
            builder: (context, state) {
              return BotaoDefaultWidget(
                desabilitado: !state.podeSalvar,
                textoBotao: "Salvar",
                onPressed: () {
                  Navigator.pop(context, context.read<QuestaoProvasCubit>().state.provasMarcadas);
                },
              );
            },
          ),
        ],
      );
    },
  );
}
