import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class ChartWidget extends StatelessWidget {
  final String title;
  final List<double> data;
  final List<String> labels;
  final double maxValue;
  final Color? barColor;
  final Color? highlightColor;
  final int? highlightIndex;

  const ChartWidget({
    Key? key,
    required this.title,
    required this.data,
    required this.labels,
    this.maxValue = 100,
    this.barColor,
    this.highlightColor,
    this.highlightIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryBarColor = barColor ?? AppColors.primaryPurple;
    final primaryHighlightColor = highlightColor ?? AppColors.info;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              // Chart Area
              SizedBox(
                height: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    data.length,
                    (index) {
                      final value = data[index];
                      final height = (value / maxValue) * 150;
                      final isHighlight =
                          highlightIndex != null && highlightIndex == index;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Value Label
                          Text(
                            value.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Bar
                          Container(
                            width: 32,
                            height: height,
                            decoration: BoxDecoration(
                              color: isHighlight
                                  ? primaryHighlightColor
                                  : primaryBarColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  labels.length,
                  (index) => Text(
                    labels[index],
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
