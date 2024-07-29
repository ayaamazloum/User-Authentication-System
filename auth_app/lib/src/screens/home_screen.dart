import 'dart:convert';
import 'package:auth_app/src/services/api_service.dart';
import 'package:auth_app/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = AuthService();
  final storage = FlutterSecureStorage();
  String userName = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // Fetch user data from the backend to showcase the validation of the token at each and every api request (edge cases)
  Future<void> getUserData() async {
    final result = await API(context: context).sendRequest(route: '/me', method: 'get');
    if (result.statusCode == 200) {
      final response = jsonDecode(result.body);
      print(response['name']);
      if (response['status'] == 'success') {
        setState(() {
          userName = response['name'];
        });
      }
    } else {
      print('Failed to load user data');
    }
  }

  // Handle user logout
  void logout(BuildContext context) async {
    try {
      await _authService.logout();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome $userName'),
            ElevatedButton(
              onPressed: () {
                logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
