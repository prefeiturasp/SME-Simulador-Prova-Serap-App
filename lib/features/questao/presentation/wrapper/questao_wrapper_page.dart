import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/features/questao/presentation/cubits/questao/questao_cubit.dart';
import 'package:serap_simulador/features/questao/presentation/cubits/questao_editar/questao_editar_cubit.dart';
import 'package:serap_simulador/injector.dart';

@RoutePage()
class QuestaoWrapperPage extends StatelessWidget {
  const QuestaoWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<QuestaoCubit>()),
        BlocProvider(create: (context) => sl<QuestaoEditarCubit>()),
      ],
      child: AutoRouter(),
    );
  }
}
