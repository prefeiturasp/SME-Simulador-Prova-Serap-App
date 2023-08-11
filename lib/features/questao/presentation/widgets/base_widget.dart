import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:serap_simulador/core/utils/colors.dart';
import 'package:serap_simulador/injector.dart';
import 'package:serap_simulador/shared/presentation/widgets/cabecalho.dart';

class BaseWidget extends StatefulWidget {
  const BaseWidget({super.key, this.appBar, required this.child});

  final PreferredSizeWidget? appBar;
  final Widget child;

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  double defaultPadding = 16;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: TemaUtil.corDeFundo,
        appBar: widget.appBar ?? buildAppBar(),
        persistentFooterButtons: _buildPersistentFooterButtons(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: WillPopScope(
                onWillPop: () async {
                  return true;
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: defaultPadding,
                    right: defaultPadding,
                    top: defaultPadding,
                    bottom: 0,
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget>? _buildPersistentFooterButtons() {
    return [
      Center(
        child: Text(
          '${sl<PackageInfo>().version} Build ${sl<PackageInfo>().buildNumber}',
          style: TextStyle(
            color: TemaUtil.preto,
            fontSize: 14,
          ),
        ),
      )
    ];
  }

  PreferredSizeWidget buildAppBar() {
    return Cabecalho(
      mostrarBotaoSair: false,
    );
  }
}
