import 'package:flutter/material.dart';
import 'package:serap_simulador/core/utils/colors.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_video_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';

import 'questao_admin.widget.dart';

class QuestaoConteudoWidget extends StatelessWidget {
  const QuestaoConteudoWidget({
    super.key,
    required this.questaoCompleta,
  });

  final QuestaoCompleta questaoCompleta;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context, questaoCompleta),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Questão ${questaoCompleta.questao.ordem + 1} ',
                  style: TextStyle(
                    color: TemaUtil.preto,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SelectionArea(
              child: QuestaoAdminWidget(
                questao: questaoCompleta.questao,
                alternativas: questaoCompleta.alternativas,
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  double? getWidth(BuildContext context, QuestaoCompleta questaoCompleta) {
    var width = exibirVideo(questaoCompleta.videos) ? MediaQuery.of(context).size.width * 0.5 : null;
    return width;
  }

  bool exibirVideo(List<ArquivoVideo> videos) {
    if (videos.isEmpty) {
      return false;
    }

    return true;
  }
}
