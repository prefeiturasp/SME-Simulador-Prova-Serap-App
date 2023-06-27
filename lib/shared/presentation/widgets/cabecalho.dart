import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';
import 'package:serap_simulador/features/auth/data/datasources/autenticacao_local_datasource.dart';
import 'package:serap_simulador/injector.dart';

import '../../../core/utils/colors.dart';
import '../../../features/auth/presentation/cubits/auth/auth_cubit.dart';

class Cabecalho extends StatelessWidget implements PreferredSizeWidget {
  final bool mostrarBotaoSair;

  final String? titulo;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const Cabecalho({
    super.key,
    this.mostrarBotaoSair = true,
    this.titulo,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 24 for default icon size
      toolbarHeight: kToolbarHeight,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: leading ?? _buildBackButton(context),
      title: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                titulo ?? 'Simulador SERAp Estudantes',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ...actions ?? [],
        mostrarBotaoSair
            ? BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    authenticated: (usuario) {
                      return InkWell(
                        onTap: () async {
                          await sl<IAutenticacaoLocalDataSource>().apagarToken();
                          context.replaceRoute(LoginRoute());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.exit_to_app_outlined,
                              color: TemaUtil.laranja02,
                            ),
                          ],
                        ),
                      );
                    },
                    orElse: () {
                      return SizedBox.shrink();
                    },
                  );
                },
              )
            : SizedBox.shrink(),
      ],
    );
  }

  _buildBackButton(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    final bool canPop = parentRoute?.canPop ?? false;

    if ((canPop) || (parentRoute?.impliesAppBarDismissal ?? false)) {
      return InkWell(
        onTap: () {
          Navigator.maybePop(context);
        },
        child: Icon(
          size: 24,
          Icons.arrow_back,
          color: Colors.white,
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
