// widgets/saving_goal_card.dart
import 'package:flutter/material.dart';

class SavingGoalCard extends StatelessWidget {
  final double currentAmount;
  final double goalAmount;

  const SavingGoalCard({
    super.key,
    required this.currentAmount,
    required this.goalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (currentAmount / goalAmount).clamp(0.0, 1.0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Target Menabung',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Rp${currentAmount.toStringAsFixed(2)} dari Rp${goalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${(percentage * 100).toStringAsFixed(1)}% tercapai',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}