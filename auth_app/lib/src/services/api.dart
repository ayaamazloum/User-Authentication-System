import 'dart:convert';
import 'package:auth_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class API {
  API({required this.context});

  late BuildContext context;

  sendRequest(
      {required String route,
      required String method,
      Map<String, dynamic>? data}) async {
    String url = apiUrl + route;
    FlutterSecureStorage storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    http.Response response;
    try {
      if (method == 'get') {
        response = await http.get(Uri.parse(url), headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
      } else {
        response =
            await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
      }

      // Handle edge cases on each and every api request: If the token is invalid or expired, redirect to the login page
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Navigator.pushReplacementNamed(context, '/login');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Token is invalid or expired. Please log in again.',
              style: TextStyle(fontSize: 12, color: Colors.red.shade800),
            ),
            backgroundColor: Colors.grey.shade200,
            elevation: 30,
          ),
        );
      }

      return response;
    } catch (e) {
      print(e);
      return jsonEncode(e);
    }
  }
}
