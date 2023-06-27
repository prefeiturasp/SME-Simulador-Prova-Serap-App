import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class EditorHtmlEnhanced extends StatefulWidget {
  const EditorHtmlEnhanced({
    super.key,
    required this.text,
    required this.onTextChanged,
  });

  final String text;
  final Function(String?) onTextChanged;

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
      ),
      child: HtmlEditor(
        controller: controller,
        callbacks: Callbacks(
          onChangeContent: widget.onTextChanged,
        ),
        htmlToolbarOptions: HtmlToolbarOptions(
          toolbarType: ToolbarType.nativeGrid,
          defaultToolbarButtons: [
            FontButtons(
              subscript: false,
              superscript: false,
            ),
            ListButtons(
              listStyles: false,
            ),
            ParagraphButtons(
              lineHeight: false,
              caseConverter: false,
              textDirection: false,
            ),
            InsertButtons(
              audio: false,
              picture: false,
              video: false,
            ),
            OtherButtons(
              fullscreen: false,
              copy: false,
              paste: false,
              help: false,
              undo: false,
              redo: false,
            ),
          ],
        ),
        htmlEditorOptions: HtmlEditorOptions(
          initialText: widget.text,
        ),
        otherOptions: OtherOptions(
          height: 300,
        ),
      ),
    );
  }
}
