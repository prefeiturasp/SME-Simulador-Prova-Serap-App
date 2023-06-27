import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../widgets/editor_html_enhanced.dart';

@RoutePage()
class QuestaoEditPage extends StatefulWidget {
  final int cadernoId;
  final int questaoId;

  QuestaoEditPage({
    super.key,
    @PathParam('cadernoId') required this.cadernoId,
    @PathParam('questaoId') required this.questaoId,
  });

  @override
  State<QuestaoEditPage> createState() => _QuestaoEditPageState();
}

class _QuestaoEditPageState extends State<QuestaoEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar questao'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Titulo
                  _buildEditorTitulo(),
                  // Descricao
                  _buildEditorDescricao(),

                  // Alternativas
                  _buildEditorAlternativas(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditorTitulo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Titulo',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        EditorHtmlEnhanced(
          text: '<h1>Hello</h1><p>This is a quill html editor example 😊</p>',
          onTextChanged: (p0) {},
        ),
      ],
    );
  }

  Widget _buildEditorDescricao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Descrição'),
        EditorHtmlEnhanced(
          text: '<h1>Hello</h1><p>This is a quill html editor example 😊</p>',
          onTextChanged: (p0) {},
        ),
      ],
    );
  }

  Widget _buildEditorAlternativas() {
    return Row(
      children: [
        Container(),
      ],
    );
  }
}
