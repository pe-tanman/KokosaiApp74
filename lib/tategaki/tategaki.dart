// コピペ：https://qiita.com/sakusaku3939/items/64d453f4cf4be875aa67

import 'package:flutter/material.dart';
import 'package:kokosai_74_app/tategaki/vertical_rotated.dart';


class Tategaki extends StatelessWidget {
  const Tategaki(
      this.text, {Key? key,
        this.style,
        this.space = 12,
      }) : super(key: key);

  final String text;
  final TextStyle? style;
  final double space;

  @override
  Widget build(BuildContext context) {
    final mergeStyle = DefaultTextStyle.of(context).style.merge(style);
    return LayoutBuilder(
      builder: (context, constraints) {
        return RepaintBoundary(
          child: CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight - 4),
            painter: _TategakiPainter(text, mergeStyle, space),
          ),
        );
      },
    );
  }
}

class _TategakiPainter extends CustomPainter {
  _TategakiPainter(this.text, this.style, this.space);

  final String text;
  final TextStyle style;
  final double space;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();

    final columnCount = size.height ~/ style.fontSize!;
    final rowCount = (text.length / columnCount).ceil();

    for (int x = 0; x < rowCount; x++) {
      drawTextLine(canvas, size, x, columnCount);
    }

    canvas.restore();
  }

  void drawTextLine(Canvas canvas, Size size, int x, int columnCount) {
    final runes = text.runes;
    final fontSize = style.fontSize!;
    final charWidth = fontSize + space;

    for (int y = 0; y < columnCount; y++) {
      final charIndex = x * columnCount + y;
      if (runes.length <= charIndex) return;

      String char = String.fromCharCode(runes.elementAt(charIndex));
      if (VerticalRotated.map[char] != null) {
        char = VerticalRotated.map[char] ?? "";
      }

      TextSpan span = TextSpan(
        style: style,
        text: char,
      );
      TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      );

      tp.layout();
      tp.paint(
        canvas,
        Offset(
          (size.width - (x + 1) * charWidth).toDouble(),
          (y * fontSize).toDouble(),
        ),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

