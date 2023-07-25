import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_default.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/cabecalho.dart';
import 'package:serap_simulador/shared/presentation/widgets/dialog/dialogs.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../../../shared/presentation/widgets/buttons/botao_secundario.widget.dart';
import '../cubits/questao_editar/questao_editar_cubit.dart';
import '../widgets/base_widget.dart';
import '../widgets/questao_completa_widget.dart';

@RoutePage()
class QuestaoEditarPreviewPage extends StatefulWidget {
  final int cadernoId;
  final int questaoId;

  const QuestaoEditarPreviewPage({
    super.key,
    @PathParam('cadernoId') required this.cadernoId,
    @PathParam('questaoId') required this.questaoId,
  });

  @override
  State<QuestaoEditarPreviewPage> createState() => _QuestaoEditarPreviewPageState();
}

class _QuestaoEditarPreviewPageState extends State<QuestaoEditarPreviewPage> {
  double defaultPadding = 16;

  @override
  void initState() {
    super.initState();
    context.read<QuestaoEditarCubit>().carregarQuestao(widget.cadernoId, widget.questaoId);
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
    return BaseWidget(
      appBar: Cabecalho(
        mostrarBotaoSair: false,
        leading: _buildBotaoVoltarLeading(context),
      ),
      child: BlocConsumer<QuestaoEditarCubit, QuestaoEditarState>(
        listener: (context, state) {
          if (state.status == Status.salvo) {
            context.router.navigate(
              ResumoCadernoProvaRoute(
                key: Key('${widget.cadernoId}'),
                cadernoId: widget.cadernoId,
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case Status.carregando:
              return Center(
                child: CircularProgressIndicator(),
              );

            case Status.carregado:
              return QuestaoCompletaWidget(
                questaoCompleta: state.questaoCompleta!,
                cadernoId: widget.cadernoId,
                exibirBotoes: false,
                botoesBuilder: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BotaoSecundarioWidget(
                      textoBotao: 'Cancelar',
                      onPressed: () async {
                        context.router.popUntil(
                          (route) {
                            if ((route.data?.name ?? '') == QuestaoRoute.name) {
                              return true;
                            }

                            return false;
                          },
                        );
                      },
                    ),
                    BotaoDefaultWidget(
                      textoBotao: 'Salvar',
                      onPressed: () async {
                        List<String>? provasQuestao = await mostrarDialogSelecaoProva(context, widget.questaoId);

                        if (provasQuestao != null) {
                          context.read<QuestaoEditarCubit>().salvarQuestao(provasQuestao);
                        }
                      },
                    ),
                  ],
                ),
              );

            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
