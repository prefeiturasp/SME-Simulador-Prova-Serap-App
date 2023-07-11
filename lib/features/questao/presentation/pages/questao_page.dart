import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../../../shared/presentation/widgets/cabecalho.dart';
import '../../../auth/presentation/cubits/auth/auth_cubit.dart';
import '../cubits/questao/questao_cubit.dart';
import '../widgets/base_widget.dart';
import '../widgets/questao_completa_widget.dart';

@RoutePage()
class QuestaoPage extends StatefulWidget {
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
        if (context.router.canPop()) {
          context.router.pop();
        } else {
          context.router.replace(
            ResumoCadernoProvaRoute(
              key: Key('${widget.cadernoId}'),
              cadernoId: widget.cadernoId,
            ),
          );
        }
      },
    );
  }

  double defaultPadding = 16;

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      context.read<QuestaoCubit>().carregarQuestaoCompleta(widget.cadernoId, widget.questaoId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: buildAppBar(),
      child: BlocBuilder<QuestaoCubit, QuestaoState>(
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
            erro: (erro) {
              return Text(erro);
            },
            orElse: () {
              return SizedBox.shrink();
            },
          );
        },
      ),
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
