import 'dart:math';
import 'package:flutter/material.dart';

class ActivityRingsPainter extends CustomPainter {
  final double moveProgress;
  final double exerciseProgress;
  final double standProgress;

  ActivityRingsPainter({
    required this.moveProgress,
    required this.exerciseProgress,
    required this.standProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = size.width * 0.1;

    final radiuses = [
      (size.width - strokeWidth) / 2,
      (size.width - strokeWidth * 3) / 2,
      (size.width - strokeWidth * 5) / 2,
    ];

    _drawBackgroundRings(canvas, center, radiuses, strokeWidth);

    _drawRing(
      canvas: canvas,
      center: center,
      radius: radiuses[2],
      strokeWidth: strokeWidth,
      progress: standProgress,
      color: const Color(0xFF00F5FF),
    );
    _drawEndWithShadow(
      canvas: canvas,
      center: center,
      radius: radiuses[2],
      strokeWidth: strokeWidth,
      progress: standProgress,
      color: const Color(0xFF00F5FF),
    );

    _drawRing(
      canvas: canvas,
      center: center,
      radius: radiuses[1],
      strokeWidth: strokeWidth,
      progress: exerciseProgress,
      color: const Color(0xFFFFF500),
    );
    _drawEndWithShadow(
      canvas: canvas,
      center: center,
      radius: radiuses[1],
      strokeWidth: strokeWidth,
      progress: exerciseProgress,
      color: const Color(0xFFFFF500),
    );

    _drawRing(
      canvas: canvas,
      center: center,
      radius: radiuses[0],
      strokeWidth: strokeWidth,
      progress: moveProgress,
      color: const Color(0xFFFF2D55),
    );
    _drawEndWithShadow(
      canvas: canvas,
      center: center,
      radius: radiuses[0],
      strokeWidth: strokeWidth,
      progress: moveProgress,
      color: const Color(0xFFFF2D55),
    );
  }

  void _drawBackgroundRings(Canvas canvas, Offset center, List<double> radiuses, double strokeWidth) {
    final bgPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (final radius in radiuses) {
      canvas.drawCircle(center, radius, bgPaint);
    }
  }

  void _drawRing({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required double strokeWidth,
    required double progress,
    required Color color,
  }) {
    if (progress <= 0) return;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final startAngle = -pi / 2;
    final sweepAngle = progress >= 0.99 ? 2 * pi : 2 * pi * progress;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }


  void _drawEndWithShadow({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required double strokeWidth,
    required double progress,
    required Color color,
  }) {
    if (progress <= 0) return;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final startAngle = -pi / 2;
    final endAngle = startAngle + (progress >= 0.99 ? 2 * pi : 2 * pi * progress);

    // Тень под концом линии
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 1.4
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Рисуем тень под концом линии с плавным началом
    canvas.drawArc(
      rect,
      endAngle - 0.01,
      0.11,
      false,
      shadowPaint,
    );

    // Рисуем сам конец линии поверх тени
    final endPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 1.01
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      endAngle - 0.1,
      0.1,
      false,
      endPaint,
    );
  }

  @override
  bool shouldRepaint(ActivityRingsPainter oldDelegate) {
    return oldDelegate.moveProgress != moveProgress ||
        oldDelegate.exerciseProgress != exerciseProgress ||
        oldDelegate.standProgress != standProgress;
  }
}