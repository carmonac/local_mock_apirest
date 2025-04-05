import 'dart:io';

import 'package:args/args.dart';
import 'package:local_mock_apirest/local_mock_apirest.dart'
    as local_mock_apirest;

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('port',
        abbr: 'p', defaultsTo: '8080', help: 'The port to listen on.')
    ..addOption('path',
        abbr: 'f',
        defaultsTo: './mock.yaml',
        help: 'The path to the YAML file.');

  final argResults = parser.parse(arguments);

  final port = int.parse(argResults['port'] as String);
  final yamlFilePath = argResults['path'] as String;

  final file = File(yamlFilePath);

  if (!file.existsSync()) {
    print('File not found.');
    return;
  }

  final directory = file.parent;
  final fileName = file.uri.pathSegments.last;

  final watcher = directory.watch(events: FileSystemEvent.modify);

  watcher.listen((event) {
    if (event is FileSystemModifyEvent && event.path.endsWith(fileName)) {
      print('File $fileName has been modified.');
      stopServer();
      startServer(port, file);
    }
  });

  startServer(port, file);
}

void startServer(int port, File file) async {
  await local_mock_apirest
      .startServer(local_mock_apirest.Options(port: port, file: file));
}

Future<void> stopServer() async {
  await local_mock_apirest.stopServer();
}
