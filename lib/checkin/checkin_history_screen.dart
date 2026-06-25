import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class CheckInHistoryScreen extends StatefulWidget {
  const CheckInHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CheckInHistoryScreen> createState() => _CheckInHistoryScreenState();
}

class _CheckInHistoryScreenState extends State<CheckInHistoryScreen> {
  // Mock data - replace with actual data from service
  final List<CheckInRecord> _checkInHistory = [
    CheckInRecord(
      date: DateTime.now(),
      mood: 4,
      stressLevel: 3,
      energyLevel: 7,
      sleepQuality: 8,
      factors: ['Exercise', 'Social'],
      notes: 'Had a great workout and caught up with friends.',
    ),
    CheckInRecord(
      date: DateTime.now().subtract(const Duration(days: 1)),
      mood: 3,
      stressLevel: 6,
      energyLevel: 5,
      sleepQuality: 6,
      factors: ['Work Stress'],
      notes: 'Busy day at work, feeling tired.',
    ),
    CheckInRecord(
      date: DateTime.now().subtract(const Duration(days: 2)),
      mood: 5,
      stressLevel: 2,
      energyLevel: 8,
      sleepQuality: 9,
      factors: ['Exercise', 'Weather'],
      notes: 'Beautiful day! Feeling energized.',
    ),
    CheckInRecord(
      date: DateTime.now().subtract(const Duration(days: 3)),
      mood: 2,
      stressLevel: 8,
      energyLevel: 3,
      sleepQuality: 4,
      factors: ['Sleep Issues', 'Work Stress', 'Caffeine'],
      notes: 'Didn\'t sleep well. Need to reduce caffeine intake.',
    ),
    CheckInRecord(
      date: DateTime.now().subtract(const Duration(days: 4)),
      mood: 3,
      stressLevel: 5,
      energyLevel: 6,
      sleepQuality: 7,
      factors: ['Social'],
      notes: 'Spent time with family.',
    ),
  ];

  final List<String> _moodEmojis = ['😢', '😕', '😐', '🙂', '😄'];
  final List<String> _moodLabels = ['Very Bad', 'Bad', 'Okay', 'Good', 'Great'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Check-in History',
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
      body: _checkInHistory.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _checkInHistory.length,
              itemBuilder: (context, index) {
                final record = _checkInHistory[index];
                return _buildCheckInCard(record);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.history_outlined,
              size: 50,
              color: AppColors.primaryPurple,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Check-ins Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Start your wellness journey by taking your first daily check-in.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInCard(CheckInRecord record) {
    final moodIndex = record.mood - 1;
    final isToday = DateTime.now().difference(record.date).inDays == 0;
    final dateStr = isToday
        ? 'Today'
        : '${record.date.month}/${record.date.day}/${record.date.year}';

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
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(16),
        childrenPadding: const EdgeInsets.all(16),
        leading: Text(
          _moodEmojis[moodIndex],
          style: const TextStyle(fontSize: 32),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateStr,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _moodLabels[moodIndex],
              style: TextStyle(
                fontSize: 12,
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.expand_more,
          color: AppColors.textSecondary,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Metrics Grid
              _buildMetricsGrid(record),
              const SizedBox(height: 16),
              const Divider(color: AppColors.border),
              const SizedBox(height: 16),

              // Factors
              if (record.factors.isNotEmpty) ...[
                const Text(
                  'Contributing Factors',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: record.factors.map((factor) {
                    return Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPurple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        factor,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.border),
                const SizedBox(height: 16),
              ],

              // Notes
              if (record.notes.isNotEmpty) ...[
                const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.bgSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    record.notes,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(CheckInRecord record) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        _buildMetricBox(
          label: 'Stress',
          value: '${record.stressLevel}',
          unit: '/10',
          color: AppColors.warning,
        ),
        _buildMetricBox(
          label: 'Energy',
          value: '${record.energyLevel}',
          unit: '/10',
          color: AppColors.info,
        ),
        _buildMetricBox(
          label: 'Sleep',
          value: '${record.sleepQuality}',
          unit: '/10',
          color: AppColors.success,
        ),
        _buildMetricBox(
          label: 'Mood',
          value: '${record.mood}',
          unit: '/5',
          color: AppColors.primaryPurple,
        ),
      ],
    );
  }

  Widget _buildMetricBox({
    required String label,
    required String value,
    required String unit,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 9,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckInRecord {
  final DateTime date;
  final int mood; // 1-5
  final int stressLevel; // 0-10
  final int energyLevel; // 0-10
  final int sleepQuality; // 0-10
  final List<String> factors;
  final String notes;

  CheckInRecord({
    required this.date,
    required this.mood,
    required this.stressLevel,
    required this.energyLevel,
    required this.sleepQuality,
    this.factors = const [],
    this.notes = '',
  });
}
