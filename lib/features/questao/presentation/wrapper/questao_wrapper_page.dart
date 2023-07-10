import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class QuestaoWrapperPage extends StatefulWidget {
  const QuestaoWrapperPage({super.key});

  @override
  State<QuestaoWrapperPage> createState() => _QuestaoWrapperPageState();
}

class _QuestaoWrapperPageState extends State<QuestaoWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
