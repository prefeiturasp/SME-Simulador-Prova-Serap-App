import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';
import 'package:serap_simulador/core/utils/tela_adaptativa.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_video_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_default.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_secundario.widget.dart';

class BotoesControleWidget extends StatefulWidget {
  const BotoesControleWidget({
    super.key,
    required this.cadernoId,
    required this.questaoCompleta,
  });

  final int cadernoId;
  final QuestaoCompleta questaoCompleta;

  @override
  State<BotoesControleWidget> createState() => _BotoesControleWidgetState();
}

class _BotoesControleWidgetState extends State<BotoesControleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 20,
      ),
      child: _buildBotoes(
        widget.questaoCompleta.videos,
        widget.questaoCompleta.questaoAnteriorId,
        widget.questaoCompleta.proximaQuestaoId,
      ),
    );
  }

  Widget _buildBotoes(List<ArquivoVideo> videos, int? questaoIdAnterior, int? questaoIdProxima) {
    Widget botoesRespondendoProva = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildBotaoVoltar(questaoIdAnterior),
        _buildBotaoProximo(questaoIdProxima),
      ],
    );

    if (kIsMobile || videos.isNotEmpty) {
      botoesRespondendoProva = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBotaoVoltar(questaoIdAnterior),
          _buildBotaoProximo(questaoIdProxima),
        ],
      );
    }

    return botoesRespondendoProva;
  }

  Widget _buildBotaoVoltar(int? questaoIdAnterior) {
    if (questaoIdAnterior == null) {
      return SizedBox.shrink();
    }

    return BotaoSecundarioWidget(
      textoBotao: 'Item anterior',
      onPressed: () async {
        context.router.replace(
          QuestaoRoute(
            key: Key('${widget.cadernoId}-$questaoIdAnterior'),
            cadernoId: widget.cadernoId,
            questaoId: questaoIdAnterior,
          ),
        );
      },
    );
  }

  Widget _buildBotaoProximo(int? questaoIdProxima) {
    if (questaoIdProxima != null) {
      return BotaoDefaultWidget(
        textoBotao: 'Próximo item',
        onPressed: () async {
          context.router.replace(
            QuestaoRoute(
              key: Key('${widget.cadernoId}-$questaoIdProxima'),
              cadernoId: widget.cadernoId,
              questaoId: questaoIdProxima,
            ),
          );
        },
      );
    }

    return BotaoDefaultWidget(
      textoBotao: 'Voltar para o resumo',
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
}
