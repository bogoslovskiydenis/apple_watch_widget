import 'package:apple_watch_widget/screens/widgets/ActivityRings.dart';
import 'package:apple_watch_widget/screens/widgets/ProgressSlider.dart';
import 'package:flutter/material.dart';

import '../ActivityRings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double moveProgress = 0.75;
  double exerciseProgress = 0.9;
  double standProgress = 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Активность'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ActivityRings(
                moveProgress: moveProgress,
                exerciseProgress: exerciseProgress,
                standProgress: standProgress,
                size: 250,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ProgressSlider(
                  label: 'Движение',
                  value: moveProgress,
                  color: const Color(0xFFFF2D55),
                  onChanged: (value) => setState(() => moveProgress = value),
                ),
                ProgressSlider(
                  label: 'Тренировки',
                  value: exerciseProgress,
                  color: const Color(0xFFFFF500),
                  onChanged: (value) => setState(() => exerciseProgress = value),
                ),
                ProgressSlider(
                  label: 'Время на ногах',
                  value: standProgress,
                  color: const Color(0xFF00F5FF),
                  onChanged: (value) => setState(() => standProgress = value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}