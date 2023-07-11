import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:serap_simulador/core/utils/colors.dart';

class EditorHtmlQuill extends StatefulWidget {
  const EditorHtmlQuill({
    super.key,
    required this.text,
    this.onTextChanged,
    this.height = 300,
  });

  final String text;
  final Function(String)? onTextChanged;
  final double height;

  @override
  State<EditorHtmlQuill> createState() => _EditorHtmlQuillState();
}

class _EditorHtmlQuillState extends State<EditorHtmlQuill> {
  late QuillEditorController controller;

  final _backgroundColor = Colors.white70;

  final _editorTextStyle = const TextStyle(
    color: TemaUtil.preto,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  final _hintTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black12,
    fontWeight: FontWeight.normal,
  );

  final _customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.underline,
    ToolBarStyle.strike,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.indentAdd,
    ToolBarStyle.indentMinus,
    ToolBarStyle.link,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
    ToolBarStyle.align,
    ToolBarStyle.clean,
  ];

  @override
  void initState() {
    super.initState();

    controller = QuillEditorController();
    controller.setText(widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToolBar(
          toolBarColor: Colors.cyan.shade50,
          activeIconColor: Colors.green,
          padding: const EdgeInsets.all(8),
          iconSize: 20,
          toolBarConfig: _customToolBarList,
          controller: controller,
        ),
        QuillHtmlEditor(
          controller: controller,
          text: widget.text,
          isEnabled: true,
          minHeight: 300,
          textStyle: _editorTextStyle,
          hintTextStyle: _hintTextStyle,
          hintTextAlign: TextAlign.start,
          padding: const EdgeInsets.only(left: 10, top: 5),
          hintTextPadding: EdgeInsets.zero,
          backgroundColor: _backgroundColor,
          onTextChanged: widget.onTextChanged,
        ),
      ],
    );
  }
}
