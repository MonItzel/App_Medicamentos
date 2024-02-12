import 'package:flutter/material.dart';

class TextoSnackBar extends StatelessWidget {
  final String contenido;
  final double tamFontSize;
  const TextoSnackBar({required this.contenido, required this.tamFontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(contenido,
      style: TextStyle(
          fontSize: tamFontSize,
          color: Colors.white),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}