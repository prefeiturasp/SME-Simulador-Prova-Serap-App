import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:photo_view/photo_view.dart';
import 'package:serap_simulador/core/utils/colors.dart';
import 'package:serap_simulador/features/questao/presentation/widgets/render_html/render_html.dart';
import 'package:serap_simulador/shared/enums/tipo_imagem.enum.dart';
import 'package:serap_simulador/shared/enums/tratamento_imagem.enum.dart';

mixin ProvaViewUtil {
  String tratarArquivos(
    String? texto,
    EnumTipoImagem tipoImagem,
    TratamentoImagemEnum tratamentoImagem,
  ) {
    if (texto == null) {
      return "";
    }

    // Remocao fonte e tamanho do texto
    texto = texto.replaceAll(RegExp(r"font-family:[^;']*(;)?"), '');
    texto = texto.replaceAll(RegExp(r"font-size:[^;']*(;)?"), '');

    // Remocao quebra desnecessaria
    texto = texto.replaceAll('<br></p>', '</p>');

    texto = texto.replaceAllMapped(RegExp(r'(<img[^>]*>)'), (match) {
      return '<div style="text-align: center; position:relative">${match.group(0)}<p><span>Toque na imagem para ampliar</span></p></div>';
    });

    return texto;
  }

  Widget renderizarHtml(
    BuildContext context,
    String? texto,
    EnumTipoImagem tipoImagem,
    TratamentoImagemEnum tratamentoImagem,
  ) {
    return RenderHtml(
      html: tratarArquivos(texto, tipoImagem, tratamentoImagem),
      onImageTap: (String src) async {
        await _exibirImagem(context, src);
      },
    );
  }

  Future<Uint8List> networkAssetBundleFromUrl(String url) async {
    final uri = Uri.parse(url);
    final Response response = await get(uri);
    return response.bodyBytes;
  }

  Future<T?> _exibirImagem<T>(BuildContext context, String? url) async {
    late Uint8List imagem;

    if (url!.startsWith('http')) {
      imagem = await networkAssetBundleFromUrl(url.replaceFirst('http://', 'https://'));
    } else {
      imagem = base64.decode(url.split(',').last);
    }

    return await showDialog<T>(
      context: context,
      builder: (_) {
        var background = Colors.transparent;

        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.black.withOpacity(0.5),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Align(
                    alignment: Alignment.center,
                    child: PhotoView(
                      backgroundDecoration: BoxDecoration(color: background),
                      imageProvider: MemoryImage(imagem),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.close, color: TemaUtil.laranja02),
                        SizedBox(
                          width: 8,
                        ),
                        Observer(
                          builder: (_) {
                            return Text(
                              'Fechar',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
