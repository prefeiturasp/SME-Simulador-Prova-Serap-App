import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serap_simulador/shared/enums/tipo_dispositivo.enum.dart';

var kDeviceType = EnumTipoDispositivo.TABLET;

var kIsMobile = kDeviceType == EnumTipoDispositivo.MOBILE;
var kIsTablet = kDeviceType == EnumTipoDispositivo.TABLET;

class TelaAdaptativaUtil {
  setup() {
    // ignore: deprecated_member_use
    final tela = MediaQueryData.fromView(WidgetsBinding.instance.window);
    if (kIsWeb) {
      kDeviceType = EnumTipoDispositivo.WEB;
    } else if (Platform.isAndroid || Platform.isIOS) {
      kDeviceType = tela.size.shortestSide < 600 ? EnumTipoDispositivo.MOBILE : EnumTipoDispositivo.TABLET;
    }
  }
}
