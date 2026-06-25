import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class SliderWidget extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final Color? color;
  final String? unit;
  final bool showValue;
  final int divisions;

  const SliderWidget({
    Key? key,
    required this.label,
    required this.value,
    this.min = 0,
    this.max = 100,
    required this.onChanged,
    this.color,
    this.unit,
    this.showValue = true,
    this.divisions = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sliderColor = color ?? AppColors.primaryPurple;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            if (showValue)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: sliderColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${value.toStringAsFixed(0)}${unit ?? ''}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: sliderColor,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),

        // Slider
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 6,
            activeTrackColor: sliderColor,
            inactiveTrackColor: sliderColor.withOpacity(0.2),
            thumbColor: sliderColor,
            thumbShape: RoundSliderThumbShape(
              elevation: 4,
              enabledThumbRadius: 12,
            ),
            overlayColor: sliderColor.withOpacity(0.2),
            overlayShape: RoundSliderOverlayShape(
              overlayRadius: 20,
            ),
            valueIndicatorColor: sliderColor,
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
            label: '${value.toStringAsFixed(0)}',
          ),
        ),

        // Labels
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                min.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                max.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
