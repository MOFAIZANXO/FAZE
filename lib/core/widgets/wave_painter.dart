import 'dart:math';
import 'package:flutter/material.dart';

class WaterWavePainter extends CustomPainter {
  final double fillPercent;
  final double wavePhase;
  final List<Color>? colors;

  WaterWavePainter({
    required this.fillPercent,
    required this.wavePhase,
    this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final waterPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors ?? [
          const Color(0xFF4FC3F7).withOpacity(0.8), // Light Blue
          const Color(0xFF0288D1),                 // Deeper Blue
          const Color(0xFF01579B),                 // Dark Water Blue
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final waterLevel = size.height * (1 - fillPercent);

    // Start path
    path.moveTo(0, waterLevel);

    // Create wave
    for (double x = 0; x <= size.width; x += 1) {
      final y = waterLevel +
          8 * sin((x / size.width * 2 * pi) + (wavePhase * 2 * pi));
      path.lineTo(x, y);
    }

    // Complete path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, waterPaint);

    // Add wave shimmer
    final shimmerPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final shimmerPath = Path();
    shimmerPath.moveTo(0, waterLevel);
    for (double x = 0; x <= size.width; x += 1) {
      final y = waterLevel +
          8 * sin((x / size.width * 2 * pi) + (wavePhase * 2 * pi));
      shimmerPath.lineTo(x, y);
    }
    canvas.drawPath(shimmerPath, shimmerPaint);
  }

  @override
  bool shouldRepaint(WaterWavePainter old) =>
      old.fillPercent != fillPercent || old.wavePhase != wavePhase;
}
