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
    controller.onTextChanged(widget.onTextChanged);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
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
      child: Column(
        children: [
          ToolBar(
            toolBarColor: TemaUtil.branco,
            activeIconColor: TemaUtil.laranja01,
            padding: const EdgeInsets.all(8),
            iconSize: 20,
            controller: controller,
            toolBarConfig: _customToolBarList,
            customButtons: [
              InkWell(
                child: const Icon(Icons.code),
                onTap: () {},
              ),
            ],
          ),
          QuillHtmlEditor(
            text: widget.text,
            hintText: 'Digite o texto',
            controller: controller,
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
      ),
    );
  }
}
