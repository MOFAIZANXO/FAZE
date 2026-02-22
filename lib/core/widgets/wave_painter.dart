import 'dart:math';
import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double animationValue;
  final double fillPercent;

  WavePainter({required this.animationValue, required this.fillPercent});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyan.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    final y = size.height * (1 - fillPercent);

    path.moveTo(0, y);
    for (double x = 0; x <= size.width; x++) {
      path.lineTo(
        x,
        y + 8 * sin((x / size.width * 2 * pi) + (animationValue * 2 * pi)),
      );
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter old) => true;
}
