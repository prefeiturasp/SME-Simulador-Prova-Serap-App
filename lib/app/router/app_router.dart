import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';

@Singleton()
@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    // Resumo Prova
    AutoRoute(page: ResumoCadernoProvaRoute.page, path: '/resumo/caderno/:cadernoId'),

    // Detalhes da Questao
    AutoRoute(
      path: "/prova/caderno",
      page: QuestaoWrapperRoute.page,
      children: [
        AutoRoute(
          page: QuestaoRoute.page,
          path: ':cadernoId/questao/:questaoId',
        ),
        AutoRoute(
          page: QuestaoEditarRoute.page,
          path: ':cadernoId/questao/:questaoId/editar',
        ),
        AutoRoute(
          page: QuestaoEditarPreviewRoute.page,
          path: ':cadernoId/questao/:questaoId/editar/visualizar',
        ),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),

    // Auth
    AutoRoute(page: LoginRoute.page, path: '/login/:codigo/:cadernoId'),
    AutoRoute(page: LandingRoute.page, path: '/'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
