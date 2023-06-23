import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract class BaseStatefulWidget extends StatefulHookWidget {
  final String? title;
  const BaseStatefulWidget({Key? key, this.title}) : super(key: key);
}
