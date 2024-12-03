import 'package:flutter/material.dart';

import '../../ActivityRings.dart';

class ActivityRings extends StatelessWidget {
  final double moveProgress;
  final double exerciseProgress;
  final double standProgress;
  final double size;

  const ActivityRings({
    super.key,
    this.moveProgress = 1.0,
    this.exerciseProgress = 1.0,
    this.standProgress = 1.0,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: ActivityRingsPainter(
                moveProgress: moveProgress,
                exerciseProgress: exerciseProgress,
                standProgress: standProgress,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLegendItem(
          color: const Color(0xFFFF3B30),
          label: 'Движение',
          progress: (moveProgress * 100).toInt(),
        ),
        const SizedBox(height: 8),
        _buildLegendItem(
          color: const Color(0xFF00FF00),
          label: 'Тренировки',
          progress: (exerciseProgress * 100).toInt(),
        ),
        const SizedBox(height: 8),
        _buildLegendItem(
          color: const Color(0xFF0066FF),
          label: 'Время на ногах',
          progress: (standProgress * 100).toInt(),
        ),
      ],
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required int progress,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$label: $progress%',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}