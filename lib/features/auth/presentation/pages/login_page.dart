import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serap_simulador/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:serap_simulador/shared/presentation/widgets/rodape.dart';

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 44),
            BlocBuilder<LoginCubit, LoginState>(
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
