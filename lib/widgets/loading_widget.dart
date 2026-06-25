import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final LoadingType type;
  final Color? color;

  const LoadingWidget({
    Key? key,
    this.message,
    this.type = LoadingType.circular,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingColor = color ?? AppColors.primaryPurple;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLoader(loadingColor),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoader(Color color) {
    switch (type) {
      case LoadingType.circular:
        return SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 4,
          ),
        );

      case LoadingType.dots:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimatedDot(0, color),
            const SizedBox(width: 8),
            _buildAnimatedDot(1, color),
            const SizedBox(width: 8),
            _buildAnimatedDot(2, color),
          ],
        );

      case LoadingType.gradient:
        return SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 4,
            backgroundColor: color.withOpacity(0.2),
          ),
        );

      case LoadingType.shimmer:
        return SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 3,
          ),
        );
    }
  }

  Widget _buildAnimatedDot(int index, Color color) {
    return AnimatedBuilder(
      animation: AlwaysStoppedAnimation(0.0),
      builder: (context, child) {
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        );
      },
    );
  }
}

enum LoadingType {
  circular,
  dots,
  gradient,
  shimmer,
}
