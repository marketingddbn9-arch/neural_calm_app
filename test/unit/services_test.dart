import 'package:flutter_test/flutter_test.dart';
import 'package:neural_calm/utils/validators.dart';
import 'package:neural_calm/utils/formatters.dart';
import 'package:neural_calm/utils/constants.dart';

void main() {
  group('Validators Tests', () {
    group('Email Validation', () {
      test('Valid email should return null', () {
        final result = Validators.validateEmail('user@example.com');
        expect(result, isNull);
      });

      test('Invalid email should return error message', () {
        final result = Validators.validateEmail('invalid-email');
        expect(result, isNotNull);
      });

      test('Empty email should return error', () {
        final result = Validators.validateEmail('');
        expect(result, isNotNull);
      });

      test('Email without @ should return error', () {
        final result = Validators.validateEmail('userexample.com');
        expect(result, isNotNull);
      });
    });

    group('Password Validation', () {
      test('Strong password should be valid', () {
        final result = Validators.validatePassword('SecurePass123!');
        expect(result, isNull);
      });

      test('Password too short should return error', () {
        final result = Validators.validatePassword('Short1!');
        expect(result, isNotNull);
      });

      test('Password without uppercase should return error', () {
        final result = Validators.validatePassword('lowercase123!');
        expect(result, isNotNull);
      });

      test('Password without number should return error', () {
        final result = Validators.validatePassword('NoNumber!');
        expect(result, isNotNull);
      });

      test('Password without special char should return error', () {
        final result = Validators.validatePassword('NoSpecial123');
        expect(result, isNotNull);
      });

      test('Empty password should return error', () {
        final result = Validators.validatePassword('');
        expect(result, isNotNull);
      });
    });

    group('Password Confirmation Validation', () {
      test('Matching passwords should return null', () {
        final result = Validators.validateConfirmPassword(
          'SecurePass123!',
          'SecurePass123!',
        );
        expect(result, isNull);
      });

      test('Non-matching passwords should return error', () {
        final result = Validators.validateConfirmPassword(
          'SecurePass123!',
          'DifferentPass123!',
        );
        expect(result, isNotNull);
      });

      test('Empty confirm password should return error', () {
        final result = Validators.validateConfirmPassword('', 'password');
        expect(result, isNotNull);
      });
    });

    group('Name Validation', () {
      test('Valid name should return null', () {
        final result = Validators.validateName('John Doe');
        expect(result, isNull);
      });

      test('Single letter name should return error', () {
        final result = Validators.validateName('A');
        expect(result, isNotNull);
      });

      test('Name with numbers should return error', () {
        final result = Validators.validateName('John123');
        expect(result, isNotNull);
      });

      test('Empty name should return error', () {
        final result = Validators.validateName('');
        expect(result, isNotNull);
      });

      test('Name with apostrophe should be valid', () {
        final result = Validators.validateName("O'Brien");
        expect(result, isNull);
      });
    });

    group('Phone Number Validation', () {
      test('Valid 10 digit phone should return null', () {
        final result = Validators.validatePhoneNumber('5551234567');
        expect(result, isNull);
      });

      test('Valid formatted phone should return null', () {
        final result = Validators.validatePhoneNumber('(555) 123-4567');
        expect(result, isNull);
      });

      test('Phone too short should return error', () {
        final result = Validators.validatePhoneNumber('123');
        expect(result, isNotNull);
      });

      test('Empty phone should return error', () {
        final result = Validators.validatePhoneNumber('');
        expect(result, isNotNull);
      });
    });

    group('Age Validation', () {
      test('Valid age should return null', () {
        final result = Validators.validateAge('25');
        expect(result, isNull);
      });

      test('Age less than 13 should return error', () {
        final result = Validators.validateAge('12');
        expect(result, isNotNull);
      });

      test('Age greater than 120 should return error', () {
        final result = Validators.validateAge('121');
        expect(result, isNotNull);
      });

      test('Non-numeric age should return error', () {
        final result = Validators.validateAge('abc');
        expect(result, isNotNull);
      });

      test('Empty age should return error', () {
        final result = Validators.validateAge('');
        expect(result, isNotNull);
      });
    });

    group('Bio Validation', () {
      test('Valid bio should return null', () {
        final result = Validators.validateBio('I am a wellness enthusiast');
        expect(result, isNull);
      });

      test('Empty bio should return null (optional)', () {
        final result = Validators.validateBio('');
        expect(result, isNull);
      });

      test('Bio too short should return error', () {
        final result = Validators.validateBio('Short');
        expect(result, isNotNull);
      });

      test('Bio too long should return error', () {
        final bio = 'a' * (AppConstants.maxBioLength + 1);
        final result = Validators.validateBio(bio);
        expect(result, isNotNull);
      });
    });
  });

  group('Formatters Tests', () {
    group('Date Formatting', () {
      test('Format date should return formatted string', () {
        final date = DateTime(2024, 1, 15);
        final formatted = Formatters.formatDate(date);
        expect(formatted, contains('Jan'));
      });

      test('Format time should return time string', () {
        final time = DateTime(2024, 1, 15, 14, 30);
        final formatted = Formatters.formatTime(time);
        expect(formatted, isNotEmpty);
      });
    });

    group('Relative Time Formatting', () {
      test('Time just now', () {
        final now = DateTime.now();
        final formatted = Formatters.formatRelativeTime(now);
        expect(formatted, 'just now');
      });

      test('Time minutes ago', () {
        final minutesAgo = DateTime.now().subtract(const Duration(minutes: 5));
        final formatted = Formatters.formatRelativeTime(minutesAgo);
        expect(formatted, contains('minutes ago'));
      });

      test('Time hours ago', () {
        final hoursAgo = DateTime.now().subtract(const Duration(hours: 2));
        final formatted = Formatters.formatRelativeTime(hoursAgo);
        expect(formatted, contains('hours ago'));
      });
    });

    group('Number Formatting', () {
      test('Format number with thousand separator', () {
        final result = Formatters.formatNumber(1500);
        expect(result, '1,500');
      });

      test('Format currency', () {
        final result = Formatters.formatCurrency(99.99);
        expect(result, contains('99.99'));
      });

      test('Format percentage', () {
        final result = Formatters.formatPercentage(75);
        expect(result, '75%');
      });

      test('Abbreviate number to K', () {
        final result = Formatters.abbreviateNumber(1500);
        expect(result, '1.5K');
      });

      test('Abbreviate number to M', () {
        final result = Formatters.abbreviateNumber(1500000);
        expect(result, '1.5M');
      });
    });

    group('Text Formatting', () {
      test('Capitalize first letter', () {
        final result = Formatters.capitalizeFirstLetter('hello');
        expect(result, 'Hello');
      });

      test('Convert to title case', () {
        final result = Formatters.toTitleCase('hello world');
        expect(result, 'Hello World');
      });

      test('Convert to sentence case', () {
        final result = Formatters.toSentenceCase('hello world');
        expect(result, 'Hello world');
      });

      test('Truncate text', () {
        final result = Formatters.truncateText('Hello World', 8);
        expect(result, 'Hello...');
      });

      test('Convert to slug', () {
        final result = Formatters.toSlug('Hello World');
        expect(result, 'hello-world');
      });
    });

    group('Mood Formatting', () {
      test('Mood 1 to emoji', () {
        final result = Formatters.moodToEmoji(1);
        expect(result, '😢');
      });

      test('Mood 5 to emoji', () {
        final result = Formatters.moodToEmoji(5);
        expect(result, '😄');
      });

      test('Mood 1 to text', () {
        final result = Formatters.moodToText(1);
        expect(result, 'Terrible');
      });

      test('Mood 5 to text', () {
        final result = Formatters.moodToText(5);
        expect(result, 'Great');
      });
    });

    group('Phone Number Formatting', () {
      test('Format 10 digit phone', () {
        final result = Formatters.formatPhoneNumber('5551234567');
        expect(result, contains('555'));
      });
    });

    group('Duration Formatting', () {
      test('Format duration less than hour', () {
        final duration = const Duration(minutes: 45, seconds: 30);
        final result = Formatters.formatDuration(duration);
        expect(result, contains('45'));
      });

      test('Format duration with hours', () {
        final duration = const Duration(hours: 2, minutes: 30);
        final result = Formatters.formatDuration(duration);
        expect(result, startsWith('2'));
      });
    });

    group('File Size Formatting', () {
      test('Format bytes', () {
        final result = Formatters.formatFileSize(500);
        expect(result, '500 B');
      });

      test('Format kilobytes', () {
        final result = Formatters.formatFileSize(1024 * 2);
        expect(result, contains('KB'));
      });

      test('Format megabytes', () {
        final result = Formatters.formatFileSize(1024 * 1024 * 5);
        expect(result, contains('MB'));
      });
    });
  });

  group('Constants Tests', () {
    test('AppConstants has valid values', () {
      expect(AppConstants.appName, isNotEmpty);
      expect(AppConstants.appVersion, isNotEmpty);
      expect(AppConstants.baseUrl, isNotEmpty);
    });

    test('Mood values are in valid range', () {
      expect(AppConstants.moodTerribleValue, 1);
      expect(AppConstants.moodBadValue, 2);
      expect(AppConstants.moodOkayValue, 3);
      expect(AppConstants.moodGoodValue, 4);
      expect(AppConstants.moodGreatValue, 5);
    });

    test('Metric ranges are valid', () {
      expect(AppConstants.minStress, 0);
      expect(AppConstants.maxStress, 10);
      expect(AppConstants.minEnergy, 0);
      expect(AppConstants.maxEnergy, 10);
    });

    test('Check-in factors list is not empty', () {
      expect(AppConstants.checkInFactors, isNotEmpty);
      expect(AppConstants.checkInFactors.length, greaterThan(0));
    });

    test('Password minimum length is reasonable', () {
      expect(AppConstants.minPasswordLength, greaterThanOrEqualTo(8));
    });

    test('Route names are defined', () {
      expect(AppConstants.routeHome, isNotEmpty);
      expect(AppConstants.routeLogin, isNotEmpty);
      expect(AppConstants.routeProfile, isNotEmpty);
    });
  });

  group('Integration Tests', () {
    test('Email validation and formatting', () {
      final email = ' USER@EXAMPLE.COM ';
      final formatted = Formatters.formatEmail(email);
      final isValid = Validators.validateEmail(formatted);

      expect(isValid, isNull); // Valid
      expect(formatted, 'user@example.com');
    });

    test('User age and bio validation', () {
      final age = '25';
      final bio = 'Wellness enthusiast focused on mental health';

      final ageValid = Validators.validateAge(age);
      final bioValid = Validators.validateBio(bio);

      expect(ageValid, isNull); // Valid
      expect(bioValid, isNull); // Valid
    });

    test('Phone and name validation together', () {
      final name = 'John Doe';
      final phone = '5551234567';

      final nameValid = Validators.validateName(name);
      final phoneValid = Validators.validatePhoneNumber(phone);

      expect(nameValid, isNull);
      expect(phoneValid, isNull);
    });
  });
}
