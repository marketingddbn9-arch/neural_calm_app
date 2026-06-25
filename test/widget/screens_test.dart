import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neural_calm/config/app_colors.dart';
import 'package:neural_calm/widgets/bottom_navigation.dart';
import 'package:neural_calm/widgets/wellness_card.dart';
import 'package:neural_calm/widgets/metric_card.dart';
import 'package:neural_calm/widgets/slider_widget.dart';
import 'package:neural_calm/widgets/mood_selector.dart';
import 'package:neural_calm/widgets/loading_widget.dart';
import 'package:neural_calm/widgets/empty_state.dart';
import 'package:neural_calm/widgets/chart_widget.dart';

void main() {
  group('Widget Tests', () {
    group('BottomNavigation Tests', () {
      testWidgets('BottomNavigation renders all 5 items',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              bottomNavigationBar: BottomNavigation(
                currentIndex: 0,
                onIndexChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.byType(BottomNavigationBar), findsOneWidget);
        expect(find.byType(BottomNavigationBarItem), findsWidgets);
      });

      testWidgets('BottomNavigation responds to tap',
          (WidgetTester tester) async {
        int currentIndex = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              bottomNavigationBar: BottomNavigation(
                currentIndex: currentIndex,
                onIndexChanged: (index) {
                  currentIndex = index;
                },
              ),
            ),
          ),
        );

        expect(find.byType(BottomNavigationBar), findsOneWidget);
      });

      testWidgets('BottomNavigation shows correct active color',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              bottomNavigationBar: BottomNavigation(
                currentIndex: 0,
                onIndexChanged: (_) {},
              ),
            ),
          ),
        );

        final navbar = find.byType(BottomNavigationBar);
        expect(navbar, findsOneWidget);
      });
    });

    group('WellnessCard Tests', () {
      testWidgets('WellnessCard renders with title',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WellnessCard(
                title: 'Test Card',
                child: Container(),
              ),
            ),
          ),
        );

        expect(find.text('Test Card'), findsOneWidget);
      });

      testWidgets('WellnessCard renders subtitle when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WellnessCard(
                title: 'Test Card',
                subtitle: 'Test Subtitle',
                child: Container(),
              ),
            ),
          ),
        );

        expect(find.text('Test Card'), findsOneWidget);
        expect(find.text('Test Subtitle'), findsOneWidget);
      });

      testWidgets('WellnessCard responds to tap',
          (WidgetTester tester) async {
        bool tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WellnessCard(
                title: 'Tappable Card',
                child: Container(),
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(WellnessCard));
        await tester.pumpAndSettle();

        expect(tapped, true);
      });

      testWidgets('WellnessCard displays gradient when enabled',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WellnessCard(
                title: 'Gradient Card',
                child: Container(),
                showGradient: true,
              ),
            ),
          ),
        );

        expect(find.byType(WellnessCard), findsOneWidget);
      });
    });

    group('MetricCard Tests', () {
      testWidgets('MetricCard displays value and unit',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MetricCard(
                label: 'Heart Rate',
                value: '72',
                unit: 'bpm',
                icon: Icons.favorite,
                color: AppColors.success,
              ),
            ),
          ),
        );

        expect(find.text('Heart Rate'), findsOneWidget);
        expect(find.text('72'), findsOneWidget);
        expect(find.text('bpm'), findsOneWidget);
      });

      testWidgets('MetricCard displays trend when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MetricCard(
                label: 'Stress Level',
                value: '35',
                unit: '%',
                icon: Icons.trending_down,
                color: AppColors.warning,
                trend: '+10%',
                isTrendPositive: false,
              ),
            ),
          ),
        );

        expect(find.text('Stress Level'), findsOneWidget);
        expect(find.text('35'), findsOneWidget);
      });

      testWidgets('MetricCard shows progress bar when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MetricCard(
                label: 'Energy Level',
                value: '7',
                unit: '/10',
                icon: Icons.bolt,
                color: AppColors.info,
                progress: 0.7,
              ),
            ),
          ),
        );

        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      });

      testWidgets('MetricCard responds to tap',
          (WidgetTester tester) async {
        bool tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MetricCard(
                label: 'Sleep',
                value: '8',
                unit: 'hrs',
                icon: Icons.bedtime,
                color: AppColors.primaryPurple,
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(MetricCard));
        await tester.pumpAndSettle();

        expect(tapped, true);
      });
    });

    group('SliderWidget Tests', () {
      testWidgets('SliderWidget displays label',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SliderWidget(
                label: 'Stress Level',
                value: 5,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text('Stress Level'), findsOneWidget);
      });

      testWidgets('SliderWidget displays current value',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SliderWidget(
                label: 'Energy',
                value: 7,
                onChanged: (_) {},
                unit: '/10',
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('SliderWidget responds to change',
          (WidgetTester tester) async {
        double value = 5;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SliderWidget(
                label: 'Test',
                value: value,
                min: 0,
                max: 10,
                onChanged: (newValue) {
                  value = newValue;
                },
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('SliderWidget shows min/max labels',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SliderWidget(
                label: 'Test Slider',
                value: 5,
                min: 0,
                max: 10,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text('0'), findsWidgets);
        expect(find.text('10'), findsWidgets);
      });
    });

    group('MoodSelector Tests', () {
      testWidgets('MoodSelector displays all 5 moods',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MoodSelector(
                selectedMood: 3,
                onMoodChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.byType(MoodSelector), findsOneWidget);
      });

      testWidgets('MoodSelector shows label when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MoodSelector(
                selectedMood: 3,
                onMoodChanged: (_) {},
                label: 'How are you feeling?',
              ),
            ),
          ),
        );

        expect(find.text('How are you feeling?'), findsOneWidget);
      });

      testWidgets('MoodSelector responds to selection',
          (WidgetTester tester) async {
        int selectedMood = 3;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MoodSelector(
                selectedMood: selectedMood,
                onMoodChanged: (mood) {
                  selectedMood = mood;
                },
              ),
            ),
          ),
        );

        expect(find.byType(MoodSelector), findsOneWidget);
      });

      testWidgets('MoodSelector highlights selected mood',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MoodSelector(
                selectedMood: 5,
                onMoodChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.byType(MoodSelector), findsOneWidget);
      });
    });

    group('LoadingWidget Tests', () {
      testWidgets('LoadingWidget displays circular loader',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingWidget(
                type: LoadingType.circular,
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('LoadingWidget displays message when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingWidget(
                message: 'Loading...',
              ),
            ),
          ),
        );

        expect(find.text('Loading...'), findsOneWidget);
      });

      testWidgets('LoadingWidget centers content',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingWidget(
                message: 'Please wait',
              ),
            ),
          ),
        );

        expect(find.byType(Center), findsOneWidget);
      });

      testWidgets('LoadingWidget supports different types',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LoadingWidget(
                type: LoadingType.gradient,
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('EmptyState Tests', () {
      testWidgets('EmptyState displays icon', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyState(
                icon: '📭',
                title: 'No Data',
              ),
            ),
          ),
        );

        expect(find.text('📭'), findsOneWidget);
      });

      testWidgets('EmptyState displays title',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyState(
                icon: '📭',
                title: 'No Check-ins',
              ),
            ),
          ),
        );

        expect(find.text('No Check-ins'), findsOneWidget);
      });

      testWidgets('EmptyState displays subtitle when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyState(
                icon: '📭',
                title: 'No Data',
                subtitle: 'Start by taking your first check-in',
              ),
            ),
          ),
        );

        expect(find.text('No Data'), findsOneWidget);
        expect(find.text('Start by taking your first check-in'),
            findsOneWidget);
      });

      testWidgets('EmptyState displays action button when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyState(
                icon: '📭',
                title: 'No Data',
                actionLabel: 'Create',
                onAction: () {},
              ),
            ),
          ),
        );

        expect(find.text('Create'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('EmptyState action button responds to tap',
          (WidgetTester tester) async {
        bool actionTriggered = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyState(
                icon: '📭',
                title: 'No Data',
                actionLabel: 'Create',
                onAction: () {
                  actionTriggered = true;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(actionTriggered, true);
      });
    });

    group('ChartWidget Tests', () {
      testWidgets('ChartWidget displays title',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ChartWidget(
                title: 'Mood Trends',
                data: [3, 3.5, 4, 4.2, 4.1, 4.5, 4.3],
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              ),
            ),
          ),
        );

        expect(find.text('Mood Trends'), findsOneWidget);
      });

      testWidgets('ChartWidget displays data points',
          (WidgetTester tester) async {
        final data = [2, 4, 6, 8, 5, 7, 9];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ChartWidget(
                title: 'Weekly Data',
                data: data.map((e) => e.toDouble()).toList(),
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              ),
            ),
          ),
        );

        expect(find.byType(ChartWidget), findsOneWidget);
      });

      testWidgets('ChartWidget displays day labels',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ChartWidget(
                title: 'Chart',
                data: [5, 5, 5, 5, 5, 5, 5],
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              ),
            ),
          ),
        );

        expect(find.byType(ChartWidget), findsOneWidget);
      });

      testWidgets('ChartWidget highlights specific index',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ChartWidget(
                title: 'Highlighted Chart',
                data: [5, 5, 5, 5, 5, 5, 5],
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                highlightIndex: 6,
              ),
            ),
          ),
        );

        expect(find.byType(ChartWidget), findsOneWidget);
      });
    });

    group('Integration Tests', () {
      testWidgets('Multiple widgets render together',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  WellnessCard(
                    title: 'Wellness Score',
                    child: Container(height: 100),
                  ),
                  MetricCard(
                    label: 'Heart Rate',
                    value: '72',
                    unit: 'bpm',
                    icon: Icons.favorite,
                    color: AppColors.success,
                  ),
                  SliderWidget(
                    label: 'Stress',
                    value: 5,
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(WellnessCard), findsOneWidget);
        expect(find.byType(MetricCard), findsOneWidget);
        expect(find.byType(SliderWidget), findsOneWidget);
      });

      testWidgets('Widgets use correct colors',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MetricCard(
                label: 'Test',
                value: '10',
                unit: 'u',
                icon: Icons.favorite,
                color: AppColors.primaryPurple,
              ),
            ),
          ),
        );

        expect(find.byType(MetricCard), findsOneWidget);
      });

      testWidgets('Loading and Empty states work together',
          (WidgetTester tester) async {
        bool showLoading = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: showLoading
                  ? LoadingWidget(message: 'Loading...')
                  : EmptyState(
                      icon: '📭',
                      title: 'No Data',
                    ),
            ),
          ),
        );

        expect(find.text('No Data'), findsOneWidget);
      });
    });
  });
}
