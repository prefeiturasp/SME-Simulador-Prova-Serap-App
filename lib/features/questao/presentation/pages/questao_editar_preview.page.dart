import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class QuestaoEditarPreviewPage extends StatefulWidget {
  final int cadernoId;
  final int questaoId;

  const QuestaoEditarPreviewPage({
    super.key,
    @PathParam('cadernoId') required this.cadernoId,
    @PathParam('questaoId') required this.questaoId,
  });

  @override
  State<QuestaoEditarPreviewPage> createState() => _QuestaoEditarPreviewPageState();
}

class _QuestaoEditarPreviewPageState extends State<QuestaoEditarPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
