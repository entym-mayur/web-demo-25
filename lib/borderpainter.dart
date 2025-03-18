import 'dart:math' as math;
import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  final double progress;
  BorderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..shader = SweepGradient(
        colors: [Colors.red, Colors.purple, Colors.blue, Colors.green, Colors.orange, Colors.red], // Repeating red to make a smooth transition
        stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
        transform: GradientRotation(math.pi * 2 * progress),
      ).createShader(Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2));

    // Draw the circle
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
