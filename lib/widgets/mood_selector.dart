import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class MoodSelector extends StatelessWidget {
  final int selectedMood;
  final ValueChanged<int> onMoodChanged;
  final String? label;

  const MoodSelector({
    Key? key,
    required this.selectedMood,
    required this.onMoodChanged,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moods = [
      {'emoji': '😢', 'label': 'Terrible', 'value': 1},
      {'emoji': '😕', 'label': 'Bad', 'value': 2},
      {'emoji': '😐', 'label': 'Okay', 'value': 3},
      {'emoji': '🙂', 'label': 'Good', 'value': 4},
      {'emoji': '😄', 'label': 'Great', 'value': 5},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            moods.length,
            (index) {
              final mood = moods[index];
              final isSelected = selectedMood == mood['value'];

              return GestureDetector(
                onTap: () => onMoodChanged(mood['value'] as int),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryPurple.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryPurple
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        mood['emoji'] as String,
                        style: const TextStyle(fontSize: 36),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        mood['label'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.primaryPurple
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
