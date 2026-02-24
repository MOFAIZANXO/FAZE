import 'dart:math' as math;
import 'package:flutter/material.dart';

class BlobPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  BlobPainter({
    required this.color,
    this.animationValue = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    // Create an organic blob shape using 8 points
    final points = 8;
    for (var i = 0; i <= points; i++) {
      final angle = (i / points) * math.pi * 2;
      
      // Add some "waver" to the radius based on animation and index
      final waver = math.sin(animationValue * 2 + i * 1.5) * (radius * 0.15);
      final currentRadius = radius + waver;
      
      final x = center.dx + math.cos(angle) * currentRadius;
      final y = center.dy + math.sin(angle) * currentRadius;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        // Use quadratic curves for smooth edges
        final prevAngle = ((i - 1) / points) * math.pi * 2;
        final prevWaver = math.sin(animationValue * 2 + (i - 1) * 1.5) * (radius * 0.15);
        final prevRadius = radius + prevWaver;
        
        final prevX = center.dx + math.cos(prevAngle) * prevRadius;
        final prevY = center.dy + math.sin(prevAngle) * prevRadius;
        
        final midX = (prevX + x) / 2;
        final midY = (prevY + y) / 2;
        
        path.quadraticBezierTo(prevX, prevY, midX, midY);
      }
    }
    
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant BlobPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue || oldDelegate.color != color;
  }
}

class FloatingIllustrationPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  FloatingIllustrationPainter({
    required this.color,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Draw a subtle star/sparkle
    final center = Offset(size.width / 2, size.height / 2);
    final length = (size.width / 2) * (0.8 + math.sin(animationValue * 3) * 0.2);

    // Vertical line
    canvas.drawLine(
      Offset(center.dx, center.dy - length),
      Offset(center.dx, center.dy + length),
      paint,
    );
    // Horizontal line
    canvas.drawLine(
      Offset(center.dx - length, center.dy),
      Offset(center.dx + length, center.dy),
      paint,
    );
    
    // Diagonal lines (shorter)
    final diagLength = length * 0.5;
    canvas.drawLine(
      Offset(center.dx - diagLength, center.dy - diagLength),
      Offset(center.dx + diagLength, center.dy + diagLength),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx + diagLength, center.dy - diagLength),
      Offset(center.dx - diagLength, center.dy + diagLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant FloatingIllustrationPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
