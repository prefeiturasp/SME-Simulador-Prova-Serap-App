import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';
import 'package:serap_simulador/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:serap_simulador/features/questao/presentation/cubits/questao/questao_cubit.dart';
import 'package:serap_simulador/features/questao/presentation/widgets/base_widget.dart';
import 'package:serap_simulador/features/questao/presentation/widgets/questao_completa_widget.dart';
import 'package:serap_simulador/shared/presentation/widgets/cabecalho.dart';

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
      mostrarBotaoSair: false,
      leading: _buildBotaoVoltarLeading(context),
      actions: [
        _buildBotaoEditar(widget.cadernoId, widget.questaoId),
      ],
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
      eventoDetalhesCubit.carregarQuestaoCompleta(widget.cadernoId, widget.questaoId);

      return null;
    }, []);

    return BaseWidget(
      appBar: buildAppBar(),
      child: builder(context),
    );
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
            return QuestaoCompletaWidget(
              cadernoId: widget.cadernoId,
              questaoCompleta: questaoCompleta,
            );
          },
          orElse: () {
            return SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget _buildBotaoEditar(int cadernoId, int questaoId) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeMap(
          authenticated: (value) {
            return BlocBuilder<QuestaoCubit, QuestaoState>(
              builder: (context, state) {
                bool? isProvaIniciada = false;

                isProvaIniciada = state.mapOrNull(
                  carregado: (value) => value.questaoCompleta.isProvaIniciada,
                );

                if (value.usuario.permiteEditarItem && (isProvaIniciada != null && !isProvaIniciada)) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () {
                        context.router.push(QuestaoEditarRoute(cadernoId: cadernoId, questaoId: questaoId));
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 24,
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            );
          },
          orElse: () => SizedBox.shrink(),
        );
      },
    );
  }
}
