import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';
import 'package:serap_simulador/core/utils/colors.dart';
import 'package:serap_simulador/core/utils/tela_adaptativa.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_video_entity.dart';
import 'package:serap_simulador/features/questao/domain/entities/questao_completa_entity.dart';
import 'package:serap_simulador/features/questao/presentation/cubits/questao/questao_cubit.dart';
import 'package:serap_simulador/features/questao/presentation/widgets/questao_admin.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_default.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/buttons/botao_secundario.widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/cabecalho.dart';
import 'package:serap_simulador/shared/presentation/widgets/player_audio/player_audio_widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/video_player/video_player.widget.dart';

@RoutePage()
class QuestaoPage extends StatefulHookWidget {
  final int cadernoId;
  final int questaoId;

  QuestaoPage({
    super.key,
    @PathParam('cadernoId') required this.cadernoId,
    @PathParam('questaoId') required this.questaoId,
  });

  @override
  State<QuestaoPage> createState() => _QuestaoPageState();
}

class _QuestaoPageState extends State<QuestaoPage> {
  PreferredSizeWidget buildAppBar() {
    return Cabecalho(
      leading: _buildBotaoVoltarLeading(context),
    );
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

  double defaultPadding = 16;

  @override
  Widget build(BuildContext context) {
    final eventoDetalhesCubit = BlocProvider.of<QuestaoCubit>(context);

    useEffect(() {
      eventoDetalhesCubit.carregarQuestao(widget.cadernoId, widget.questaoId);

      return null;
    }, []);

    return SafeArea(
      child: Scaffold(
        backgroundColor: TemaUtil.corDeFundo,
        appBar: buildAppBar(),
        persistentFooterButtons: _buildPersistentFooterButtons(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: WillPopScope(
                onWillPop: () async {
                  return true;
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: defaultPadding,
                    right: defaultPadding,
                    top: defaultPadding,
                    bottom: 0,
                  ),
                  child: builder(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget>? _buildPersistentFooterButtons() {
    return [
      Center(
        child: Text(
          '1.0.0',
          style: TextStyle(
            color: TemaUtil.preto,
            fontSize: 14,
          ),
        ),
      )
    ];
  }

  getPadding([EdgeInsets mobile = EdgeInsets.zero]) {
    if (kIsWeb) {
      return EdgeInsets.symmetric(
        horizontal: (MediaQuery.of(context).size.width - 600 - (24 * 2)) / 2,
      );
    } else {
      return mobile;
    }
  }

  Widget builder(BuildContext context) {
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
                              width: getWidth(questaoCompleta),
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
                                    QuestaoAdminWidget(
                                      questao: questaoCompleta.questao,
                                      alternativas: questaoCompleta.alternativas,
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
                              child: _buildBotoes(
                                questaoCompleta.videos,
                                questaoCompleta.questaoAnteriorId,
                                questaoCompleta.proximaQuestaoId,
                              ),
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

  double? getWidth(QuestaoCompleta questaoCompleta) {
    var width = exibirVideo(questaoCompleta.videos) ? MediaQuery.of(context).size.width * 0.5 : null;
    return width;
  }

  _buildLayout({required List<ArquivoVideo> videos, required Widget body}) {
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

    return PlayerWidget(
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

  Widget _buildBotoes(List<ArquivoVideo> videos, int? questaoIdAnterior, int? questaoIdProxima) {
    Widget botoesRespondendoProva = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
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
      largura: 250,
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
        largura: 250,
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
      largura: 250,
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
