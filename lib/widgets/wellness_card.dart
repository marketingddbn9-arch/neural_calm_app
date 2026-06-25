import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class WellnessCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final bool showGradient;

  const WellnessCard({
    Key? key,
    required this.title,
    this.subtitle,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.onTap,
    this.showGradient = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      decoration: BoxDecoration(
        gradient: showGradient ? AppColors.primaryGradient : null,
        color: !showGradient ? (backgroundColor ?? Colors.white) : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: showGradient
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 12,
                            color: showGradient
                                ? Colors.white.withOpacity(0.8)
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Content
            child,
          ],
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
