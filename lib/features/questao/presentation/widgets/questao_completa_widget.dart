import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_video_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/presentation/widgets/botoes_controle_widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/player_audio/player_audio_widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/separador.dart';
import 'package:serap_simulador/shared/presentation/widgets/video_player/video_player.widget.dart';

import 'questao_widget.dart';

class QuestaoCompletaWidget extends StatefulWidget {
  const QuestaoCompletaWidget({
    super.key,
    required this.cadernoId,
    required this.questaoCompleta,
    this.exibirBotoes = true,
    this.botoesBuilder,
  });

  final int cadernoId;
  final QuestaoCompleta questaoCompleta;
  final bool exibirBotoes;
  final Widget? botoesBuilder;

  @override
  State<QuestaoCompletaWidget> createState() => _QuestaoCompletaWidgetState();
}

class _QuestaoCompletaWidgetState extends State<QuestaoCompletaWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAudioPlayer(widget.questaoCompleta.audios),
        Expanded(
          child: _buildLayout(
            videos: widget.questaoCompleta.videos,
            body: SingleChildScrollView(
              child: Padding(
                padding: _exibirVideo(widget.questaoCompleta.videos) ? EdgeInsets.zero : _getPadding(),
                child: Column(
                  children: [
                    // Questao
                    QuestaoConteudoWidget(questaoCompleta: widget.questaoCompleta),

                    // Botões
                    _buildBotoesControle(),
                    widget.botoesBuilder ?? SizedBox.shrink(),
                    Separador(
                      espacamento: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBotoesControle() {
    if (widget.exibirBotoes) {
      return BotoesControleWidget(
        cadernoId: widget.cadernoId,
        questaoCompleta: widget.questaoCompleta,
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildLayout({required List<ArquivoVideo> videos, required Widget body}) {
    if (_exibirVideo(videos)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: body,
          ),
          _buildVideoPlayer(videos),
        ],
      );
    } else {
      return body;
    }
  }

  Widget _buildVideoPlayer(List<ArquivoVideo> videos) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: EdgeInsets.only(right: 16),
      child: VideoPlayerWidget(
        videoUrl: videos.first.path,
      ),
    );
  }

  EdgeInsets _getPadding([EdgeInsets mobile = EdgeInsets.zero]) {
    if (kIsWeb) {
      return EdgeInsets.symmetric(
        horizontal: (MediaQuery.of(context).size.width - 600 - (24 * 2)) / 2,
      );
    } else {
      return mobile;
    }
  }

  Widget _buildAudioPlayer(List<Arquivo> audios) {
    if (!_exibirAudio(audios)) {
      return SizedBox.shrink();
    }

    return PlayerWidget(
      audioPath: audios.first.caminho,
    );
  }

  bool _exibirAudio(List<Arquivo> audios) {
    if (audios.isEmpty) {
      return false;
    }

    return true;
  }

  bool _exibirVideo(List<ArquivoVideo> videos) {
    if (videos.isEmpty) {
      return false;
    }

    return true;
  }
}
