import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:serap_simulador/core/utils/colors.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_video_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/presentation/cubits/questao/questao_cubit.dart';
import 'package:serap_simulador/features/questao/presentation/widgets/questao_admin.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/audio_player/audio_player.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_default.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_secundario.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/video_player/video_player.widget.dart';

@RoutePage()
class QuestaoPage extends StatefulHookWidget {
  const QuestaoPage({
    super.key,
    @PathParam('cadernoId') required this.cadernoId,
    @PathParam('questaoId') required this.questaoId,
  });

  final int cadernoId;
  final int questaoId;

  @override
  State createState() => _QuestaoPageState();
}

class _QuestaoPageState extends State<QuestaoPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestaoCubit, QuestaoState>(
      builder: (context, state) {
        return state.maybeWhen(
          carregando: () {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text("Carregando..."),
              ],
            );
          },
          carregado: (questaoCompleta) {
            return Column(
              children: [
                _buildAudioPlayer(questaoCompleta.audios),
                Expanded(
                  child: _buildLayout(
                    videos: questaoCompleta.videos,
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: exibirVideo(questaoCompleta.videos) ? EdgeInsets.zero : getPadding(),
                        child: Column(
                          children: [
                            SizedBox(
                              width:
                                  exibirVideo(questaoCompleta.videos) ? MediaQuery.of(context).size.width * 0.5 : null,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Questão ',
                                          style: TextStyle(
                                            color: TemaUtil.preto,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    BlocBuilder<QuestaoCubit, QuestaoState>(
                                      builder: (context, state) {
                                        return state.maybeWhen(
                                          carregado: (QuestaoCompleta questaoCompleta) {
                                            return QuestaoAdminWidget(
                                              questao: questaoCompleta.questao,
                                              imagens: questaoCompleta.imagens,
                                              alternativas: questaoCompleta.alternativas,
                                            );
                                          },
                                          orElse: () => SizedBox.shrink(),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                                bottom: 20,
                              ),
                              child: _buildBotoes(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          orElse: () {
            return SizedBox.shrink();
          },
        );
      },
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

  _buildLayout({required Widget body, required List<ArquivoVideo> videos}) {
    if (exibirVideo(videos)) {
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

  Widget _buildAudioPlayer(List<Arquivo> audios) {
    if (!exibirAudio(audios)) {
      return SizedBox.shrink();
    }

    return AudioPlayerWidget(
      audioPath: audios.first.caminho,
    );
  }

  Widget _buildVideoPlayer(List<ArquivoVideo> videos) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: EdgeInsets.only(right: 16),
      child: FutureBuilder<Widget>(
        future: showVideoPlayer(videos),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done ? snapshot.data! : Container();
        },
      ),
    );
  }

  Widget _buildBotoes() {
    Widget botoesRespondendoProva = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildBotaoVoltar(),
        _buildBotaoProximo(),
      ],
    );

    return botoesRespondendoProva;
  }

  Widget _buildBotaoVoltar() {
    // if (widget.ordem == 0) {
    //   return SizedBox.shrink();
    // }

    return BotaoSecundarioWidget(
      textoBotao: 'Item anterior',
      onPressed: () async {
        // context.router.push(
        //   "/admin/prova/{widget.idProva}/caderno/{widget.nomeCaderno}/questao/{widget.ordem - 1}",
        // );
      },
    );
  }

  Widget _buildBotaoProximo() {
    // if (widget.ordem < widget.resumo.length - 1) {
    //   return BotaoDefaultWidget(
    //     textoBotao: 'Próximo item',
    //     onPressed: () async {
    //       context.router.push("/admin/prova/{widget.idProva}/questao/{widget.ordem + 1}");
    //     },
    //   );
    // }

    return BotaoDefaultWidget(
      textoBotao: 'Voltar para o resumo',
      onPressed: () async {
        // context.router.push("/admin/prova/{widget.idProva}/resumo");
      },
    );
  }

  Future<Widget> showVideoPlayer(List<ArquivoVideo> videos) async {
    return VideoPlayerWidget(videoUrl: videos.first.path);
  }

  bool exibirAudio(List<Arquivo> audios) {
    if (audios.isEmpty) {
      return false;
    }

    return true;
  }

  bool exibirVideo(List<ArquivoVideo> videos) {
    if (videos.isEmpty) {
      return false;
    }

    return true;
  }
}
