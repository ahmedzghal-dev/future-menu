import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../core/constants/constants.dart';

class ApiProvider extends GetxService {
  final String baseUrl = AppConstants.baseUrl + AppConstants.apiVersion;
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Set auth token for authenticated requests
  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  // Remove auth token when logging out
  void removeAuthToken() {
    _headers.remove('Authorization');
  }

  // GET request
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      return _handleResponse(response);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  // POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  // PUT request
  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  // DELETE request
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      return _handleResponse(response);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  // Handle HTTP response
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return {
        'error': 'Request failed with status: ${response.statusCode}',
        'body': response.body,
      };
    }
  }
} 