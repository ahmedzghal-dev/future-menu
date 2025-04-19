import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../utils/app_utils.dart';

class ApiService extends GetxService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        _handleError(response);
        return null;
      }
    } catch (e) {
      AppUtils.showSnackbar(
        'Error',
        'Failed to connect to the server: ${e.toString()}',
        isError: true,
      );
      return null;
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        _handleError(response);
        return null;
      }
    } catch (e) {
      AppUtils.showSnackbar(
        'Error',
        'Failed to connect to the server: ${e.toString()}',
        isError: true,
      );
      return null;
    }
  }

  void _handleError(http.Response response) {
    AppUtils.showSnackbar(
      'Error ${response.statusCode}',
      'Failed to load data: ${response.reasonPhrase}',
      isError: true,
    );
  }
} 