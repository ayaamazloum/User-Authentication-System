import 'package:auth_app/src/screens/home_screen.dart';
import 'package:auth_app/src/screens/login_screen.dart';
import 'package:auth_app/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const AuthApp());
}

class AuthApp extends StatefulWidget {
  const AuthApp({super.key});

  @override
  State<AuthApp> createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  bool _isAuth = false;
  final storage = FlutterSecureStorage();
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  // Check if the user is authenticated by checking the stored token
  void checkAuth() async {
    final token = await storage.read(key: 'token');
    if (token != null && token.isNotEmpty) {
      validateUser();
    } else {
      setState(() {
        _isAuth = false;
      });
    }
  }

  // Validate the user by calling the backend to verify the token
  void validateUser() async {
    bool isValidUser = await _authService.validateUser();

    setState(() {
      _isAuth = isValidUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'User Authentication System',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        home: _isAuth ? HomeScreen() : LoginScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
        });
  }
}
