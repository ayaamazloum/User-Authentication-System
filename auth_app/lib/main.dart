import 'package:auth_app/src/screens/home_screen.dart';
import 'package:auth_app/src/screens/login_screen.dart';
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

    @override
  void initState() {
    super.initState();
    checkAuth();
  }

  void checkAuth() async {
    final token = await storage.read(key: 'token');
    setState(() {
      _isAuth = token != null && token.isNotEmpty ? true : false;
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
