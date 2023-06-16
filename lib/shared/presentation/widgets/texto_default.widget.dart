import 'package:flutter/material.dart';
import 'package:serap_simulador/core/utils/colors.dart';

enum Variant { primary, secondary }

class Texto extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool bold;
  final Color? color;
  final bool italic;
  final int? maxLines;
  final TextOverflow textOverflow;
  final bool center;
  final Variant variant;
  final FontWeight? fontWeight;
  final TextStyle? texStyle;
  final TextAlign? textAlign;

  Texto(
    this.text, {
    Key? key,
    this.fontSize = 10,
    this.bold = false,
    this.color,
    this.italic = false,
    this.maxLines,
    this.textOverflow = TextOverflow.ellipsis,
    this.center = false,
    this.variant = Variant.primary,
    this.fontWeight,
    this.texStyle,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? style = texStyle;

    style ??= TextStyle(fontSize: fontSize, color: color);

    style = style.copyWith(
      fontSize: fontSize,
      fontFamily: 'Poppins',
      fontWeight: style.fontWeight ?? (fontWeight ?? (bold ? FontWeight.bold : FontWeight.normal)),
      color: style.color ?? (color ?? (variant == Variant.primary ? TemaUtil.preto : TemaUtil.pretoSemFoco)),
      fontStyle: style.fontStyle ?? (italic ? FontStyle.italic : null),
    );

    return Text(
      text,
      style: style,
      textAlign: _getTextAlign(),
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }

  TextAlign? _getTextAlign() {
    if (center) {
      return TextAlign.center;
    }

    return textAlign;
  }
}
