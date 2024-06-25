import 'dart:io';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:local_mock_apirest/local_mock_apirest.dart';

void main() {
  group('Server Tests', () {
    final int port = 8080;
    final file = File(
        'test/mock.yaml'); // Asegúrate de que el archivo mock.yaml existe en esta ruta

    setUp(() async {
      final options = Options(port: port, file: file);
      await startServer(options);
    });

    tearDown(() async {
      stopServer();
    });

    test('GET / returns 200 with "Hello, world!"', () async {
      final response = await http.get(Uri.parse('http://localhost:$port/'));
      expect(response.statusCode, equals(200));
      expect(response.body, equals('Hello, world!'));
      expect(response.headers['content-type'], equals('text/plain'));
    });

    test('POST /api returns 201 with "{\"message\": \"Created\"}"', () async {
      final response = await http.post(Uri.parse('http://localhost:$port/api'));
      expect(response.statusCode, equals(201));
      expect(response.body, equals('{"message": "Created"}'));
      expect(response.headers['content-type'], equals('application/json'));
    });

    test(
        'GET /error returns 500 with "{\"message\": \"Internal Server Error\"}"',
        () async {
      final response =
          await http.get(Uri.parse('http://localhost:$port/error'));
      expect(response.statusCode, equals(500));
      expect(response.body, equals('{"message": "Internal Server Error"}'));
      expect(response.headers['content-type'], equals('application/json'));
    });

    test('GET /not_found returns 404', () async {
      final response =
          await http.get(Uri.parse('http://localhost:$port/not_found'));
      expect(response.statusCode, equals(404));
    });
  });
}
