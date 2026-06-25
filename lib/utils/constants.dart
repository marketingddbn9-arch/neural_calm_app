// App Constants
class AppConstants {
  // App Info
  static const String appName = 'Neural Calm';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your Wellness Companion';

  // API Configuration
  static const String baseUrl = 'https://api.neuralcalm.com/v1';
  static const int apiTimeout = 30; // seconds
  static const int maxRetries = 3;

  // Firebase Configuration
  static const String firebaseProjectId = 'neural-calm-firebase';
  static const String firebaseApiKey = 'YOUR_FIREBASE_API_KEY';

  // Route Names
  static const String routeSplash = '/splash';
  static const String routeLogin = '/login';
  static const String routeOnboarding = '/onboarding';
  static const String routeHome = '/home';
  static const String routeCheckIn = '/checkin';
  static const String routeCheckInSuccess = '/checkin_success';
  static const String routeCheckInHistory = '/checkin_history';
  static const String routeAnalytics = '/analytics';
  static const String routeAnalyticsDetailed = '/analytics_detailed';
  static const String routeInsights = '/insights';
  static const String routeCoach = '/coach';
  static const String routeProfile = '/profile';
  static const String routeEditProfile = '/edit_profile';
  static const String routeSettings = '/settings';
  static const String routeDevices = '/devices';

  // Mood Values
  static const int moodTerribleValue = 1;
  static const int moodBadValue = 2;
  static const int moodOkayValue = 3;
  static const int moodGoodValue = 4;
  static const int moodGreatValue = 5;

  // Metric Ranges
  static const double minStress = 0;
  static const double maxStress = 10;
  static const double minEnergy = 0;
  static const double maxEnergy = 10;
  static const double minSleep = 0;
  static const double maxSleep = 10;

  // Check-in Factors
  static const List<String> checkInFactors = [
    'Work Stress',
    'Sleep Issues',
    'Exercise',
    'Social',
    'Weather',
    'Caffeine',
  ];

  // Duration Constants
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration checkInReminderTime = Duration(hours: 9);

  // Cache Durations
  static const Duration userCacheDuration = Duration(hours: 1);
  static const Duration analyticsCacheDuration = Duration(hours: 2);
  static const Duration checkInCacheDuration = Duration(minutes: 30);

  // Validation Constants
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const int minBioLength = 10;
  static const int maxBioLength = 500;

  // Pagination
  static const int defaultPageSize = 20;
  static const int defaultInitialPage = 1;

  // Error Messages
  static const String errorNetworkException = 'Network error. Please try again.';
  static const String errorServerException = 'Server error. Please try again later.';
  static const String errorUnauthorized = 'Unauthorized. Please login again.';
  static const String errorNotFound = 'Resource not found.';
  static const String errorGeneric = 'An error occurred. Please try again.';

  // Success Messages
  static const String successLoginMessage = 'Logged in successfully!';
  static const String successSignupMessage = 'Account created successfully!';
  static const String successCheckInMessage = 'Check-in saved successfully!';
  static const String successProfileUpdateMessage = 'Profile updated successfully!';

  // Empty States
  static const String emptyCheckInsTitle = 'No Check-ins Yet';
  static const String emptyCheckInsSubtitle =
      'Start tracking your wellness journey by taking your first check-in.';
  static const String emptyAnalyticsTitle = 'No Analytics Available';
  static const String emptyAnalyticsSubtitle =
      'Complete more check-ins to see your wellness trends.';
  static const String emptyInsightsTitle = 'Insights Coming Soon';
  static const String emptyInsightsSubtitle =
      'Keep taking check-ins and we\'ll provide personalized insights.';
}

class AnimationConstants {
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration standardAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  static const Curve standardCurve = Curves.easeInOut;
  static const Curve quickCurve = Curves.easeOut;
  static const Curve slowCurve = Curves.easeInOutCubic;
}

class PaddingConstants {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

class BorderRadiusConstants {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double full = 999;
}

class FontSizeConstants {
  static const double xs = 11;
  static const double sm = 12;
  static const double md = 13;
  static const double lg = 14;
  static const double xl = 16;
  static const double xxl = 18;
  static const double xxxl = 24;
  static const double huge = 32;
}
