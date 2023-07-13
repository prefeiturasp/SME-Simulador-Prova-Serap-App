import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class EditorHtmlEnhanced extends StatefulWidget {
  const EditorHtmlEnhanced({
    super.key,
    required this.text,
    required this.onTextChanged,
    this.height = 350,
  });

  final String text;
  final Function(String?) onTextChanged;
  final double height;

  @override
  State<EditorHtmlEnhanced> createState() => _EditorHtmlEnhancedState();
}

class _EditorHtmlEnhancedState extends State<EditorHtmlEnhanced> {
  late HtmlEditorController controller;

  @override
  void initState() {
    super.initState();

    controller = HtmlEditorController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: HtmlEditor(
        controller: controller,
        callbacks: Callbacks(
          onChangeContent: widget.onTextChanged,
          onInit: () {
            // Correção de tratamento de quebras de linhas e espaços
            var text = widget.text.replaceAll('\n', " ");

            controller.setText(text);
            controller.setFullScreen();
            controller.setHint('Digite o texto');
          },
        ),
        htmlToolbarOptions: _setToolbarOptions(),
        htmlEditorOptions: HtmlEditorOptions(
          autoAdjustHeight: true,
        ),
        otherOptions: OtherOptions(
          height: widget.height,
        ),
      ),
    );
  }

  _setToolbarOptions() {
    return HtmlToolbarOptions(
      toolbarType: ToolbarType.nativeScrollable,
      defaultToolbarButtons: [
        OtherButtons(
          fullscreen: false,
          copy: false,
          paste: false,
          help: false,
          undo: false,
          redo: false,
        ),
        FontButtons(
          subscript: false,
          superscript: false,
          strikethrough: false,
        ),
        ListButtons(
          listStyles: false,
        ),
        ParagraphButtons(
          lineHeight: false,
          caseConverter: false,
          textDirection: false,
          decreaseIndent: false,
          increaseIndent: false,
        ),
        InsertButtons(
          audio: false,
          video: false,
          link: false,
          otherFile: false,
        ),
      ],
    );
  }
}
