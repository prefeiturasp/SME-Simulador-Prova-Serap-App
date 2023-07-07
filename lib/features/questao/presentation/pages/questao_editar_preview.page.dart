import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/features/questao/presentation/cubits/questao_editar/questao_editar_cubit.dart';
import 'package:serap_simulador/features/questao/presentation/widgets/base_widget.dart';
import 'package:serap_simulador/features/questao/presentation/widgets/questao_widget.dart';

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
  @override
  void initState() {
    super.initState();
    context.read<QuestaoEditarCubit>().carregarQuestao(widget.cadernoId, widget.questaoId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: BlocBuilder<QuestaoEditarCubit, QuestaoEditarState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.carregando:
              return Center(
                child: CircularProgressIndicator(),
              );

            case Status.carregado:
              return QuestaoConteudoWidget(
                questaoCompleta: state.questaoCompleta!,
              );

            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
