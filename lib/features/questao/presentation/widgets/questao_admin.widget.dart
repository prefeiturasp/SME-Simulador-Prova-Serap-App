import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:serap_simulador/features/questao/domain/entities/alternativa_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_entity.dart';
import 'package:serap_simulador/shared/enums/tipo_imagem.enum.dart';
import 'package:serap_simulador/shared/enums/tipo_questao.enum.dart';
import 'package:serap_simulador/shared/enums/tratamento_imagem.enum.dart';
import 'package:serap_simulador/shared/presentation/widgets/texto_default.widget.dart';

import 'prova.view.util.dart';

class QuestaoAdminWidget extends StatelessWidget with ProvaViewUtil {
  final controller = HtmlEditorController();

  final Questao questao;
  final List<Arquivo> imagens;
  final List<Alternativa> alternativas;

  QuestaoAdminWidget({
    Key? key,
    required this.questao,
    required this.imagens,
    required this.alternativas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (_) {
          return renderizarHtml(
            context,
            questao.titulo,
            imagens,
            EnumTipoImagem.QUESTAO,
            TratamentoImagemEnum.URL,
          );
        }),
        SizedBox(height: 8),
        Observer(builder: (_) {
          return renderizarHtml(
            context,
            questao.descricao,
            imagens,
            EnumTipoImagem.QUESTAO,
            TratamentoImagemEnum.URL,
          );
        }),
        SizedBox(height: 16),
        _buildResposta(),
      ],
    );
  }

  Widget _buildResposta() {
    switch (questao.tipo) {
      case EnumTipoQuestao.MULTIPLA_ESCOLHA:
        return _buildAlternativas();
      case EnumTipoQuestao.RESPOSTA_CONTRUIDA:
        return _buildRespostaConstruida();

      default:
        return SizedBox.shrink();
    }
  }

  _buildRespostaConstruida() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Texto(
              "Resposta Construida",
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  _buildAlternativas() {
    alternativas.sort((a, b) => a.ordem.compareTo(b.ordem));
    return ListTileTheme.merge(
      horizontalTitleGap: 0,
      child: Column(
        children: alternativas
            .map((e) => _buildAlternativa(
                  e.id,
                  e.numeracao,
                  e.descricao,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildAlternativa(int idAlternativa, String numeracao, String descricao) {
    return Observer(
      builder: (_) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black.withOpacity(0.34),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: ListTile(
            dense: true,
            title: Row(
              children: [
                Text(
                  "$numeracao ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Observer(builder: (context) {
                    return renderizarHtml(
                      context,
                      descricao,
                      imagens,
                      EnumTipoImagem.ALTERNATIVA,
                      TratamentoImagemEnum.URL,
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
