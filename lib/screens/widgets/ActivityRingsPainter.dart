//lib/widgets/activity_rings/activity_rings_painter.dart
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

    _drawRing(
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

    // Основное кольцо всегда имеет затемнение на конце
    final mainSweepAngle = progress >= 0.99 ? 2 * pi : 2 * pi * progress;

    // Создаем градиент для основного кольца
    final mainGradient = SweepGradient(
      colors: [
        color,
        color,
        color.withOpacity(0.7), // Затемнение на конце
      ],
      stops: [
        0.0,
        progress >= 0.99 ? 0.9 : (progress - 0.1),
        progress >= 0.99 ? 1.0 : progress,
      ],
      startAngle: startAngle,
      endAngle: startAngle + 2 * pi,
      transform: GradientRotation(startAngle),
    );

    // Рисуем основное кольцо с градиентом
    final mainPaint = Paint()
      ..shader = mainGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, mainSweepAngle, false, mainPaint);

    // Рисуем тень на конце
    final endAngle = startAngle + mainSweepAngle;
    _drawEndShadow(canvas, rect, endAngle, strokeWidth);

    // Если прогресс 100%, рисуем дополнительный заход
    if (progress >= 0.99) {
      final overlapAngle = 0.3;

      // Тень под заходом
      final shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 1.2
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawArc(
        rect,
        startAngle - overlapAngle,
        overlapAngle * 1.2,
        false,
        shadowPaint,
      );

      // Рисуем заход поверх с градиентом от основного цвета к черному
      final overlapGradient = LinearGradient(
        colors: [
          color.withOpacity(0.7),
          Colors.black.withOpacity(0.8),
        ],
      );

      final overlapPaint = Paint()
        ..shader = overlapGradient.createShader(
            Rect.fromCircle(center: center, radius: radius))
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 1.1
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        startAngle - overlapAngle,
        overlapAngle,
        false,
        overlapPaint,
      );
    }
  }

  void _drawEndShadow(Canvas canvas, Rect rect, double endAngle, double strokeWidth) {
    // Многослойная тень для конца линии
    final shadowPaints = [
      Paint()
        ..color = Colors.black.withOpacity(0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 1.3
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
      Paint()
        ..color = Colors.black.withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 1.1
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    ];

    for (final paint in shadowPaints) {
      canvas.drawArc(
        rect,
        endAngle - 0.15,
        0.3,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ActivityRingsPainter oldDelegate) {
    return oldDelegate.moveProgress != moveProgress ||
        oldDelegate.exerciseProgress != exerciseProgress ||
        oldDelegate.standProgress != standProgress;
  }
}