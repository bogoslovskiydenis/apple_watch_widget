import 'package:flutter/material.dart';

class ProgressSlider extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final ValueChanged<double> onChanged;

  const ProgressSlider({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${(value * 100).toInt()}%',
          style: const TextStyle(fontSize: 16),
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            thumbColor: color,
            overlayColor: color.withOpacity(0.2),
          ),
          child: Slider(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}