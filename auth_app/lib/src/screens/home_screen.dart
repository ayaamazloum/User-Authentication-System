import 'package:auth_app/src/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _authService = AuthService();

  void logout(BuildContext context) async {
    try {
      await _authService.logout();
      Navigator.of(context).pushReplacementNamed('/login');
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
            const Text('Welcome to the Home Screen!'),
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
