import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';
import 'package:serap_simulador/features/auth/data/datasources/autenticacao_local_datasource.dart';
import 'package:serap_simulador/injector.dart';

import '../../../core/utils/colors.dart';
import '../../../features/auth/presentation/cubits/auth/auth_cubit.dart';

class Cabecalho extends StatelessWidget implements PreferredSizeWidget {
  final String? titulo;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const Cabecalho({super.key, this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 24 for default icon size
      toolbarHeight: kToolbarHeight,
      centerTitle: true,
      leadingWidth: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Container(
        height: kToolbarHeight,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBackButton(context),
                Text(
                  titulo ?? 'Simulador SERAp Estudantes',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state.maybeWhen(
              authenticated: (usuario) {
                return InkWell(
                  onTap: () async {
                    await sl<IAutenticacaoLocalDataSource>().apagarToken();
                    context.replaceRoute(LoginRoute());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app_outlined, color: TemaUtil.laranja02),
                      ],
                    ),
                  ),
                );
              },
              orElse: () {
                return SizedBox.shrink();
              },
            );
          },
        ),
      ],
    );
  }

  _buildBackButton(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    final bool canPop = parentRoute?.canPop ?? false;

    if ((canPop) || (parentRoute?.impliesAppBarDismissal ?? false)) {
      return IconButton(
        onPressed: () {
          Navigator.maybePop(context);
        },
        iconSize: 16,
        icon: Icon(Icons.arrow_back),
      );
    }

    return SizedBox.shrink();
  }
}
