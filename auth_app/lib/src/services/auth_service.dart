import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl = 'http://192.168.0.115:8000/api';
  final storage = FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      await storage.write(key: 'token', value: data['token']);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    final token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('$apiUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      await storage.delete(key: 'token');
    } else {
      throw Exception('Failed to logout');
    }
  }
}
