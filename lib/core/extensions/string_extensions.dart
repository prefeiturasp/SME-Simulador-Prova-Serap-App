extension StringExtension on String {
  String tratarTexto() {
    RegExp r = RegExp(r"<[^>]*>");
    String textoNovo = replaceAll(r, '');
    textoNovo = textoNovo.replaceAll('\n', ' ').replaceAll(':', ': ');
    return textoNovo;
  }
}
