import 'dart:io';
import 'package:json_schema/json_schema.dart';
import 'package:local_mock_apirest/yaml_schema.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:yaml/yaml.dart';
import 'dart:convert';

late HttpServer _server;

class Options {
  int port;
  File file;
  Options({required this.port, required this.file});
}

Future<void> startServer(Options options) async {
  final routes = await _loadRoutes(options.file);
  final handlers = routes.map((route) {
    final path = route['path'] as String;
    final method = route['method'] as String;
    final response = route['response'];
    return _createHandler(path, method, response);
  }).toList();

  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(
    (Request request) async {
      for (var handler in handlers) {
        final response = await handler(request);
        if (response.statusCode != 404) {
          return response;
        }
      }
      return Response.notFound('Not Found');
    },
  );

  _server = await io.serve(handler, 'localhost', options.port);
  print('Server running on localhost:${_server.port}');
}

Handler _createHandler(String path, String method, dynamic response) {
  print("Method: $method, Path: $path");
  return (Request request) async {
    if (request.requestedUri.path == path && request.method == method) {
      final status = response['status'] ?? 200;
      final body = response['body'] ?? 'no content';
      final time = response['time'] ?? 0;
      final headersList = response['headers'] as List? ?? [];
      final headers = {
        for (var header in headersList)
          header['key'] as String: header['value'] as String
      };

      await Future.delayed(Duration(milliseconds: time));

      return Response(status, body: body, headers: headers);
    }
    return Response.notFound('Not Found');
  };
}

void stopServer() {
  _server.close(force: true);
}

Future<List<dynamic>> _loadRoutes(File file) async {
  final yamlString = await file.readAsString();
  final schemaJson = jsonDecode(schemaJsonString);
  final schema = JsonSchema.create(schemaJson);
  final yamlMap = loadYaml(yamlString);
  final yamlJson = jsonEncode(yamlMap);
  final validationResults = schema.validate(jsonDecode(yamlJson));
  if (!validationResults.isValid) {
    for (var error in validationResults.errors) {
      print('Error: ${error.message}');
    }
    throw Exception('YAML validation failed.');
  }

  return yamlMap['routes'] as List;
}
