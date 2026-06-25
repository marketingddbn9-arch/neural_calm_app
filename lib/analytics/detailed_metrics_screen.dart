import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class DetailedMetricsScreen extends StatefulWidget {
  const DetailedMetricsScreen({Key? key}) : super(key: key);

  @override
  State<DetailedMetricsScreen> createState() => _DetailedMetricsScreenState();
}

class _DetailedMetricsScreenState extends State<DetailedMetricsScreen> {
  final List<MetricData> _metrics = [
    MetricData(
      icon: '😊',
      name: 'Mood',
      current: 88,
      max: 100,
      average: 79.3,
      change: 12.5,
      unit: '/100',
      description: 'Overall emotional well-being',
      color: AppColors.primaryPurple,
      details: [
        'Best: Sunday (88)',
        'Worst: Wednesday (70)',
        'Consistency: 85%',
      ],
    ),
    MetricData(
      icon: '😰',
      name: 'Stress',
      current: 35,
      max: 100,
      average: 48.6,
      change: -28.0,
      unit: '/100',
      description: 'Perceived stress levels',
      color: AppColors.warning,
      details: [
        'Best: Sunday (35)',
        'Worst: Monday (70)',
        'Improvement: 50%',
      ],
    ),
    MetricData(
      icon: '⚡',
      name: 'Energy',
      current: 90,
      max: 100,
      average: 75.0,
      change: 38.5,
      unit: '/100',
      description: 'Physical and mental energy',
      color: AppColors.info,
      details: [
        'Best: Sunday (90)',
        'Worst: Wednesday (60)',
        'Peak Hours: 2-4 PM',
      ],
    ),
    MetricData(
      icon: '😴',
      name: 'Sleep',
      current: 95,
      max: 100,
      average: 80.7,
      change: 35.7,
      unit: '/100',
      description: 'Sleep quality rating',
      color: AppColors.success,
      details: [
        'Best: Sunday (95)',
        'Average: 8.0 hours',
        'Consistency: 92%',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Detailed Metrics',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _metrics.length,
        itemBuilder: (context, index) {
          return _buildMetricCard(_metrics[index]);
        },
      ),
    );
  }

  Widget _buildMetricCard(MetricData metric) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: metric.color.withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Text(
                  metric.icon,
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        metric.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        metric.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Metrics
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '${metric.current.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: metric.color,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              metric.unit,
                              style: TextStyle(
                                fontSize: 14,
                                color: metric.color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Weekly Avg',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${metric.average.toStringAsFixed(1)}${metric.unit.substring(0, 4)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: (metric.change >= 0
                                    ? AppColors.success
                                    : AppColors.warning)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                metric.change >= 0
                                    ? Icons.trending_up
                                    : Icons.trending_down,
                                size: 12,
                                color: metric.change >= 0
                                    ? AppColors.success
                                    : AppColors.warning,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${metric.change.abs().toStringAsFixed(1)}%',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: metric.change >= 0
                                      ? AppColors.success
                                      : AppColors.warning,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: (metric.current / metric.max).clamp(0, 1),
                        minHeight: 8,
                        backgroundColor: metric.color.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation(metric.color),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Details Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bgSecondary,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Key Insights',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: metric.details
                      .map(
                        (detail) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: metric.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                detail,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MetricData {
  final String icon;
  final String name;
  final double current;
  final double max;
  final double average;
  final double change;
  final String unit;
  final String description;
  final Color color;
  final List<String> details;

  MetricData({
    required this.icon,
    required this.name,
    required this.current,
    required this.max,
    required this.average,
    required this.change,
    required this.unit,
    required this.description,
    required this.color,
    required this.details,
  });
}
