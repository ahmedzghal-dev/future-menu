import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiProvider extends GetxService {
  static const String baseUrl = 'https://api.futuremenu.com/api/v1';

  final http.Client _httpClient = http.Client();

  Future<Map<String, String>> _getHeaders() async {
    // You can add auth token here
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await _httpClient.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
      );

      return _processResponse(response);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final headers = await _getHeaders();
      final response = await _httpClient.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
        body: jsonEncode(data),
      );

      return _processResponse(response);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final headers = await _getHeaders();
      final response = await _httpClient.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
        body: jsonEncode(data),
      );

      return _processResponse(response);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await _httpClient.delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
      );

      return _processResponse(response);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      return {
        'error': 'Request failed with status: ${response.statusCode}',
        'body': response.body,
      };
    }
  }
} 