import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_strings.dart';

class CheckInScreen extends StatefulWidget {
  final VoidCallback? onSuccess;

  const CheckInScreen({
    Key? key,
    this.onSuccess,
  }) : super(key: key);

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  int _selectedMood = 3; // 1-5 scale
  double _stressLevel = 5; // 0-10
  double _energyLevel = 5; // 0-10
  int _sleepQuality = 7; // 0-10
  List<String> _selectedFactors = [];
  late TextEditingController _notesController;

  final List<String> _moodOptions = ['😢', '😕', '😐', '🙂', '😄'];
  final List<String> _moodLabels = ['Very Bad', 'Bad', 'Okay', 'Good', 'Great'];
  final List<String> _allFactors = [
    'Work Stress',
    'Sleep Issues',
    'Exercise',
    'Social',
    'Weather',
    'Caffeine',
  ];

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _handleSave() {
    // Validate and save
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.success,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Check-in Saved!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Great job tracking your wellness today.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onSuccess?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Daily Check-in',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood Selector
            _buildSectionTitle('How are you feeling?'),
            const SizedBox(height: 16),
            _buildMoodSelector(),
            const SizedBox(height: 32),

            // Stress Level Slider
            _buildSectionTitle('Stress Level'),
            const SizedBox(height: 12),
            _buildSlider(
              value: _stressLevel,
              onChanged: (value) => setState(() => _stressLevel = value),
              min: 0,
              max: 10,
              label: 'Stress',
              color: AppColors.warning,
            ),
            const SizedBox(height: 32),

            // Energy Level Slider
            _buildSectionTitle('Energy Level'),
            const SizedBox(height: 12),
            _buildSlider(
              value: _energyLevel,
              onChanged: (value) => setState(() => _energyLevel = value),
              min: 0,
              max: 10,
              label: 'Energy',
              color: AppColors.info,
            ),
            const SizedBox(height: 32),

            // Sleep Quality
            _buildSectionTitle('Sleep Quality'),
            const SizedBox(height: 12),
            _buildSleepQualityButtons(),
            const SizedBox(height: 32),

            // Contributing Factors
            _buildSectionTitle('What affected your mood?'),
            const SizedBox(height: 12),
            _buildFactorsGrid(),
            const SizedBox(height: 32),

            // Notes
            _buildSectionTitle('Additional Notes'),
            const SizedBox(height: 12),
            _buildNotesField(),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Check-in',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          5,
          (index) {
            final isSelected = _selectedMood == (index + 1);
            return GestureDetector(
              onTap: () => setState(() => _selectedMood = index + 1),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryPurple.withOpacity(0.1)
                          : Colors.transparent,
                      border: isSelected
                          ? Border.all(
                              color: AppColors.primaryPurple,
                              width: 2,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        _moodOptions[index],
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _moodLabels[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? AppColors.primaryPurple
                          : AppColors.textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSlider({
    required double value,
    required ValueChanged<double> onChanged,
    required double min,
    required double max,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${value.toStringAsFixed(1)} / ${max.toInt()}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            inactiveTrackColor: color.withOpacity(0.2),
            thumbColor: color,
            overlayColor: color.withOpacity(0.3),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSleepQualityButtons() {
    return Row(
      children: List.generate(
        11,
        (index) {
          final isSelected = _sleepQuality == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _sleepQuality = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.info.withOpacity(0.2)
                      : AppColors.bgSecondary,
                  border: isSelected
                      ? Border.all(color: AppColors.info, width: 2)
                      : Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    index.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? AppColors.info : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFactorsGrid() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _allFactors.map((factor) {
        final isSelected = _selectedFactors.contains(factor);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedFactors.remove(factor);
              } else {
                _selectedFactors.add(factor);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color:
                  isSelected ? AppColors.primaryPurple : AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(20),
              border: isSelected
                  ? null
                  : Border.all(color: AppColors.border),
            ),
            child: Text(
              factor,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : AppColors.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNotesField() {
    return TextField(
      controller: _notesController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Add any additional notes or observations...',
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryPurple,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
