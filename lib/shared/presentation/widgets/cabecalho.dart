import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';
import 'package:serap_simulador/features/auth/data/datasources/autenticacao_local_datasource.dart';
import 'package:serap_simulador/gen/assets.gen.dart';
import 'package:serap_simulador/injector.dart';

import '../../../core/utils/colors.dart';

class Cabecalho extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const Cabecalho(this.titulo, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 24 for default icon size
      toolbarHeight: kToolbarHeight,
      centerTitle: false,
      leadingWidth: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Container(
        height: kToolbarHeight,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildBackButton(context),
                Text(
                  titulo,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                await sl<IAutenticacaoLocalDataSource>().apagarToken();
                context.replaceRoute(LoginRoute());
              },
              child: Row(
                children: [
                  Icon(Icons.exit_to_app_outlined, color: TemaUtil.laranja02),
                ],
              ),
            ),
          ],
        ),
      ),
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
        icon: Assets.icons.arrowBack.svg(width: 16),
      );
    }

    return SizedBox.shrink();
  }
}
