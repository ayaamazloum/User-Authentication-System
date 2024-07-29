import 'dart:convert';
import 'package:auth_app/src/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {
  @override
  Future<http.Response> post(Uri url,
      {Object? body, Encoding? encoding, Map<String, String>? headers}) {
    return super.noSuchMethod(
      Invocation.method(
          #post, [url], {#body: body, #encoding: encoding, #headers: headers}),
      returnValue: Future.value(http.Response('', 200)),
    );
  }
}

void main() {
  group('AuthService', () {
    late AuthService authService;
    late MockClient client;

    setUp(() {
      client = MockClient();
      authService = AuthService();
    });

    test('login with incorrect credentials', () async {
      final email = 'test@example.com';
      final password = 'wrongpassword';

      when(client.post(
        Uri.parse('http://192.168.1.3:8000/api/login'),
        body: {'email': email, 'password': password},
      )).thenAnswer(
        (_) async =>
            http.Response(jsonEncode({'error': 'Invalid credentials'}), 401),
      );

      expect(() => authService.login(email, password), throwsException);
    });
  });
}
