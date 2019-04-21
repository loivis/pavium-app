import 'package:flutter/material.dart';

class Paginator {
  static List<String> getPages(
      String content, double height, double width, double fontSize) {
    List<String> _pages = [];

    while (true) {
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text =
          TextSpan(text: content, style: TextStyle(fontSize: fontSize));
      textPainter.layout(maxWidth: width);

      int offset =
          textPainter.getPositionForOffset(Offset(width, height)).offset;

      if (offset == 0) {
        break;
      }

      _pages.add(content.substring(0, offset));
      content = content.substring(offset, content.length);
    }

    return _pages;
  }
}
