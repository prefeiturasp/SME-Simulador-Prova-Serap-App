import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:serap_simulador/shared/presentation/widgets/rodape.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../../../core/utils/colors.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    @PathParam('codigo') this.codigo,
  });

  final String? codigo;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    context.read<LoginCubit>().loginByCode(widget.codigo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 44),
            Visibility(
              visible: widget.codigo == null,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      Text(
                        'Código de Autenticação',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        onSubmitted: (value) {
                          context.read<LoginCubit>().loginByCode(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.pageStatus == PageStatus.sucesso) {
                  context.router.replaceAll([ResumoProvaRoute()]);
                }
              },
              builder: (context, state) {
                if (state.pageStatus.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.pageStatus.isFailure) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          "Erro ao realizar login",
                          style: TextStyle(
                            color: TemaUtil.vermelhoErro,
                          ),
                        ),
                        Text(
                          state.exceptionError,
                          style: TextStyle(
                            color: TemaUtil.vermelhoErro,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return SizedBox.shrink();
              },
            ),
            Rodape(),
          ],
        ),
      ),
    );
  }
}
