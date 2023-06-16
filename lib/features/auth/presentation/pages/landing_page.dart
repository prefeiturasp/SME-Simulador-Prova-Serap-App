import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/app/router/app_router.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';
import 'package:serap_simulador/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:serap_simulador/features/auth/presentation/cubits/cache_caderno_id/cache_caderno_id_cubit.dart';
import 'package:serap_simulador/injector.dart';

@RoutePage()
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    context.read<AuthCubit>().stream.listen((state) {
      if (state is Authenticated) {
        context.read<CacheCadernoIdCubit>().obterCadernoId().then((cadernoId) {
          if (cadernoId != null) {
            sl<AppRouter>().replaceAll([ResumoProvaRoute(cadernoId: cadernoId)]);
          }
        });
      } else {
        sl<AppRouter>().replaceAll([LoginRoute()]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
