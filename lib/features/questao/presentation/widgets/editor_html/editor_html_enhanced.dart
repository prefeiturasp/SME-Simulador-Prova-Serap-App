import 'dart:convert';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:serap_simulador/features/questao/domain/entities/arquivo_upload_entity.dart';
import 'package:serap_simulador/features/questao/domain/usecases/upload_arquivo_usecase.dart';
import 'package:serap_simulador/injector.dart';
import 'package:serap_simulador/shared/enums/file_type.enum.dart';

class EditorHtmlEnhanced extends StatefulWidget {
  const EditorHtmlEnhanced({
    super.key,
    required this.text,
    required this.onTextChanged,
    this.height = 350,
    required this.fileType,
  });

  final String text;
  final Function(String?) onTextChanged;
  final double height;
  final EnumFileType fileType;

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
      mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
        if (file.bytes != null) {
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
          }, (r) {
            controller.insertNetworkImage(r.fileLink, filename: file.name);
          });
        }

        return false;
      },
      htmlEditorStrings: TraducaoString(),
      allowImagePicking: false,
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
          table: false,
        ),
      ],
    );
  }
}

class TraducaoString extends DefaultHtmlEditorStrings {
  @override
  String get cancel => "Cancelar";

  @override
  String get text => 'Texto';

  @override
  String get close => 'Fechar';

  @override
  String get selectFromFiles => 'Inserir dos arquivos';

  @override
  String get url => 'Inserir da URL';

  @override
  String get chooseImage => 'Escolher imagem';

  @override
  String get insertLink => 'Inserir Imagem';
}
