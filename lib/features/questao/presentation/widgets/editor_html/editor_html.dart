import 'package:flutter/material.dart';

import '../../../../../shared/enums/file_type.enum.dart';
import 'editor_html_enhanced.dart';
import 'editor_html_quill.dart';

enum EditorType {
  HtmlEnhanced,
  Quill,
}

class EditorHtml extends StatefulWidget {
  const EditorHtml({
    super.key,
    required this.text,
    this.onTextChanged,
    this.height = 300,
    required this.fileType,
    this.editorType = EditorType.HtmlEnhanced,
  });

  final String text;
  final Function(String)? onTextChanged;
  final double height;
  final EnumFileType fileType;
  final EditorType editorType;

  @override
  State<EditorHtml> createState() => _EditorHtmlState();
}

class _EditorHtmlState extends State<EditorHtml> {
  @override
  Widget build(BuildContext context) {
    switch (widget.editorType) {
      case EditorType.Quill:
        return EditorHtmlQuill(
          key: widget.key,
          text: widget.text,
          fileType: widget.fileType,
          height: widget.height,
          onTextChanged: (text) {
            if (widget.onTextChanged != null) {
              widget.onTextChanged!(text);
            }
          },
        );

      case EditorType.HtmlEnhanced:
        return EditorHtmlEnhanced(
          key: widget.key,
          text: widget.text,
          fileType: widget.fileType,
          height: widget.height,
          onTextChanged: (text) {
            if (widget.onTextChanged != null) {
              widget.onTextChanged!(text);
            }
          },
        );
    }
  }
}
