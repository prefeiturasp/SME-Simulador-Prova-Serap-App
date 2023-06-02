import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:serap_simulador/app/router/app_router.gr.dart';

@RoutePage()
class CodigoPage extends HookWidget {
  const CodigoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.router.navigate(LoginRoute(
                  codigo: '31958aa9-fb0b-4d13-8a11-bf92ccde46cc',
                ));
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
