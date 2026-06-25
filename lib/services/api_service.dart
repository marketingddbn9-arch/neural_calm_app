import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://api.neuralcalm.com/v1';
  static const Duration timeout = Duration(seconds: 30);

  String? _authToken;
  bool _isOnline = true;

  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  void setOnlineStatus(bool isOnline) {
    _isOnline = isOnline;
  }

  Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  Future<dynamic> get(String endpoint) async {
    try {
      if (!_isOnline) {
        throw ApiException('No internet connection');
      }

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));

      // For demo purposes, return mock data
      return {
        'status': 'success',
        'data': {},
        'message': 'GET request to $endpoint successful',
      };
    } catch (e) {
      throw ApiException('GET request failed: ${e.toString()}');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      if (!_isOnline) {
        throw ApiException('No internet connection');
      }

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));

      // For demo purposes, return mock data
      return {
        'status': 'success',
        'data': data,
        'message': 'POST request to $endpoint successful',
      };
    } catch (e) {
      throw ApiException('POST request failed: ${e.toString()}');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      if (!_isOnline) {
        throw ApiException('No internet connection');
      }

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));

      // For demo purposes, return mock data
      return {
        'status': 'success',
        'data': data,
        'message': 'PUT request to $endpoint successful',
      };
    } catch (e) {
      throw ApiException('PUT request failed: ${e.toString()}');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      if (!_isOnline) {
        throw ApiException('No internet connection');
      }

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));

      // For demo purposes, return mock data
      return {
        'status': 'success',
        'message': 'DELETE request to $endpoint successful',
      };
    } catch (e) {
      throw ApiException('DELETE request failed: ${e.toString()}');
    }
  }

  Future<dynamic> uploadFile(String endpoint, String filePath) async {
    try {
      if (!_isOnline) {
        throw ApiException('No internet connection');
      }

      // Simulate file upload
      await Future.delayed(const Duration(seconds: 2));

      return {
        'status': 'success',
        'message': 'File uploaded successfully',
      };
    } catch (e) {
      throw ApiException('File upload failed: ${e.toString()}');
    }
  }

  void dispose() {
    // Clean up resources if needed
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}
