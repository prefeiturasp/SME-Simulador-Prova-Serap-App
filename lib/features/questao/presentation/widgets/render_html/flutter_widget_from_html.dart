import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../../core/utils/colors.dart';

class FlutterWidgetFromHtml extends StatefulWidget {
  const FlutterWidgetFromHtml({
    super.key,
    required this.html,
    required this.onImageTap,
  });

  final String html;
  final FutureOr<void> Function(String url) onImageTap;

  @override
  State<FlutterWidgetFromHtml> createState() => _FlutterWidgetFromHtmlState();
}

class _FlutterWidgetFromHtmlState extends State<FlutterWidgetFromHtml> {
  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      widget.html,
      onTapImage: (ImageMetadata imageMetadata) async {
        await widget.onImageTap(imageMetadata.sources.first.url);
      },
      textStyle: TextStyle(
        color: TemaUtil.pretoSemFoco3,
        fontSize: 16,
      ),
    );
  }
}

class _WidgetFactory extends WidgetFactory {
  @override
  void parseStyleDisplay(BuildTree tree, String? value) {
    // TODO: implement parseStyleDisplay
    print(value);
    super.parseStyleDisplay(tree, value);
  }

// @override
// void parseStyle(NodeMetadata meta, String key, String value) {
//   switch (key) {
//     case "font-size":
//       return super.parseStyle(meta, key, "18px");
//     case "font-family":
//       return super.parseStyle(meta, key, "GTWalsheimPro");
//     default:
//       super.parseStyle(meta, key, value);
//   }
}
