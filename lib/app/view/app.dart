import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serap_simulador/app/router/app_router.dart';
import 'package:serap_simulador/core/extensions/context_extensions.dart';
import 'package:serap_simulador/core/utils/colors.dart';
import 'package:serap_simulador/core/utils/constants.dart';
import 'package:serap_simulador/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:serap_simulador/features/auth/presentation/cubits/cache_caderno_id/cache_caderno_id_cubit.dart';
import 'package:serap_simulador/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:serap_simulador/features/resumo_prova/presentation/cubits/prova_resumo/prova_resumo_cubit.dart';
import 'package:serap_simulador/injector.dart';
import 'package:serap_simulador/l10n/l10n.dart';
import 'package:serap_simulador/shared/flash/presentation/blocs/cubit/flash_cubit.dart';

import '../../features/questao/presentation/cubits/questao/questao_cubit.dart';
import '../../features/questao/presentation/cubits/questao_editar/questao_editar_cubit.dart';
import '../../features/questao/presentation/cubits/questao_provas/questao_provas_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthCubit>()),
        BlocProvider(create: (context) => sl<FlashCubit>()),
        BlocProvider(create: (context) => sl<LoginCubit>()),
        BlocProvider(create: (context) => sl<CacheCadernoIdCubit>()),
        BlocProvider(create: (context) => sl<ProvaResumoCubit>()),
        BlocProvider(create: (context) => sl<QuestaoCubit>()),
        BlocProvider(create: (context) => sl<QuestaoEditarCubit>()),
        BlocProvider(create: (context) => sl<QuestaoProvasCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<FlashCubit, FlashState>(
            listener: (context, state) {
              state.when(
                disappeared: () => null,
                appeared: (message) => context.showSnackbar(
                  message: message,
                ),
              );
            },
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(ScreenUtilSize.width, ScreenUtilSize.height),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              scaffoldMessengerKey: rootScaffoldMessengerKey,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: sl<AppRouter>().config(),
              builder: (context, widget) {
                return Theme(
                  data: ThemeData(
                    scaffoldBackgroundColor: TemaUtil.corDeFundo,
                    fontFamily: 'Poppins',
                    colorScheme: ColorScheme.fromSwatch(
                      accentColor: AppColor.primary,
                    ),
                    primaryColor: TemaUtil.amarelo01,
                    appBarTheme: AppBarTheme(
                      color: TemaUtil.appBar,
                    ),
                    textTheme: Theme.of(context).textTheme.apply(
                          bodyColor: TemaUtil.preto,
                          displayColor: TemaUtil.preto,
                          fontFamily: 'Poppins',
                        ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        backgroundColor: TemaUtil.laranja01,
                        foregroundColor: TemaUtil.branco,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: TemaUtil.branco,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    buttonTheme: ButtonThemeData(
                      buttonColor: Colors.yellow,
                      textTheme: ButtonTextTheme.primary,
                      colorScheme: Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
                    ),
                  ),
                  child: widget!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
