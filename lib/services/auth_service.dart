class AuthService {
  // Simulated auth state
  String? _userId;
  String? _userEmail;
  String? _userName;
  String? _authToken;

  String? get userId => _userId;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  String? get authToken => _authToken;
  bool get isLoggedIn => _userId != null;

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Basic validation
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password are required');
      }

      if (!email.contains('@')) {
        throw Exception('Invalid email format');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Simulate successful login
      _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
      _userEmail = email;
      _userName = email.split('@').first;
      _authToken = 'token_${DateTime.now().millisecondsSinceEpoch}';

      return {
        'userId': _userId,
        'email': _userEmail,
        'name': _userName,
        'token': _authToken,
      };
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>?> signup(
    String name,
    String email,
    String password,
  ) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Basic validation
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        throw Exception('All fields are required');
      }

      if (!email.contains('@')) {
        throw Exception('Invalid email format');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Simulate successful signup
      _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
      _userEmail = email;
      _userName = name;
      _authToken = 'token_${DateTime.now().millisecondsSinceEpoch}';

      return {
        'userId': _userId,
        'email': _userEmail,
        'name': _userName,
        'token': _authToken,
      };
    } catch (e) {
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      _userId = null;
      _userEmail = null;
      _userName = null;
      _authToken = null;
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      if (email.isEmpty || !email.contains('@')) {
        throw Exception('Valid email required');
      }

      await Future.delayed(const Duration(seconds: 1));
      // Simulate password reset email sent
    } catch (e) {
      throw Exception('Password reset failed: ${e.toString()}');
    }
  }

  Future<bool> validateToken(String token) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return token == _authToken;
    } catch (e) {
      return false;
    }
  }
}
