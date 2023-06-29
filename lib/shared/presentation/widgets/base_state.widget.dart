import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:serap_simulador/core/interfaces/I_loggable.dart';

import 'appbar/appbar.widget.dart';
import 'base_statefull.widget.dart';

abstract class BaseStateWidget<TWidget extends BaseStatefulWidget> extends State<TWidget> with ILoggable {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showBottomNaviationBar = true;

  bool showAppBar = true;

  Widget? appBarTitleWidget;

  bool automaticallyImplyLeading = true;

  Color? backgroundColor;

  double defaultPadding = 16.0;
  double? defaultPaddingTop;

  bool willPop = true;

  bool? resizeToAvoidBottomInset;

  bool exibirSair = false;
  bool exibirVoltar = true;

  onAfterBuild(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onAfterBuild(context));

    return SafeArea(
      child: Observer(builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: backgroundColor,
          appBar: _showAppBar(),
          bottomNavigationBar: _buildBottomNavigationBar(),
          floatingActionButton: buildFloatingActionButton(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: WillPopScope(
                  onWillPop: () async {
                    return willPop;
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: defaultPadding,
                      top: defaultPaddingTop ?? defaultPadding,
                      bottom: showBottomNaviationBar ? 0 : defaultPadding,
                    ),
                    child: builder(context),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  getPadding([EdgeInsets mobile = EdgeInsets.zero]) {
    if (kIsWeb) {
      return EdgeInsets.symmetric(
        horizontal: (MediaQuery.of(context).size.width - 600 - (24 * 2)) / 2,
      );
    } else {
      return mobile;
    }
  }

  PreferredSizeWidget? _showAppBar() {
    if (!showAppBar) {
      return null;
    }

    return PreferredSize(
      preferredSize: Size.fromHeight(78),
      child: buildAppBar(),
    );
  }

  AppBarWidget buildAppBar() {
    return AppBarWidget(
      popView: false,
      exibirSair: exibirSair,
      mostrarBotaoVoltar: exibirVoltar,
    );
  }

  Widget? buildLeading() {
    return null;
  }

  List<Widget>? buildActions() {
    return null;
  }

  Widget? buildFloatingActionButton() {
    return null;
  }

  Widget? _buildBottomNavigationBar() {
    return null;
  }

  Widget builder(BuildContext context);
}
