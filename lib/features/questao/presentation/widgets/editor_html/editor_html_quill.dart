import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../injector.dart';
import '../../../../../shared/enums/file_type.enum.dart';
import '../../../domain/entities/arquivo_upload_entity.dart';
import '../../../domain/usecases/upload_arquivo_usecase.dart';

class EditorHtmlQuill extends StatefulWidget {
  const EditorHtmlQuill({
    super.key,
    required this.text,
    required this.onTextChanged,
    this.height = 300,
    required this.fileType,
  });

  final String text;
  final Function(String) onTextChanged;
  final double height;
  final EnumFileType fileType;

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
    ToolBarStyle.separator,
  ];

  @override
  void initState() {
    super.initState();

    controller = QuillEditorController();

    controller.onEditorLoaded(() {
      controller.setText(widget.text);
      controller.onTextChanged(
        (text) {
          widget.onTextChanged(text);
        },
      );
    });
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
                child: const Icon(Icons.image),
                onTap: () async {
                  try {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.image,
                      withData: true,
                    );

                    if (result != null) {
                      PlatformFile file = result.files.first;
                      Uint8List? bytes = file.bytes;
                      if (bytes != null) {
                        String base64Data = base64.encode(file.bytes!);

                        var arquivoUpload = ArquivoUpload(
                          contentLength: file.size,
                          contentType: file.extension!,
                          fileName: file.name,
                          inputStream: base64Data,
                          fileType: widget.fileType,
                        );

                        var result = await sl<UploadArquivoUseCase>().call(Params(arquivoUpload: arquivoUpload));
                        result.fold((l) {
                          debugPrint(l.toString());
                        }, (r) async {
                          await controller.embedImage(
                            r.fileLink,
                          );
                        });
                      }
                    }
                  } on PlatformException catch (e) {
                    debugPrint('Unsupported operation $e');
                  } catch (e) {
                    debugPrint('File Picker ${e.toString()}');
                  }
                },
              ),
              // InkWell(
              //   child: const Icon(Icons.code),
              //   onTap: () {},
              // ),
            ],
          ),
          QuillHtmlEditor(
            hintText: 'Digite o texto',
            controller: controller,
            isEnabled: true,
            minHeight: widget.height,
            textStyle: _editorTextStyle,
            hintTextStyle: _hintTextStyle,
            hintTextAlign: TextAlign.start,
            padding: const EdgeInsets.only(left: 10, top: 5),
            hintTextPadding: EdgeInsets.zero,
            backgroundColor: _backgroundColor,
            loadingBuilder: (context) {
              return Container(
                constraints: BoxConstraints(minHeight: widget.height),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
