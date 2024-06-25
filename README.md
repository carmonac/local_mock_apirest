# Local Mock API REST

This project is a local mock server that uses a YAML file to define routes, methods, and responses. The server automatically restarts if the YAML file is modified.

## Requirements

- Dart SDK

## Installation

1. Clone this repository:

    ```bash
    git clone <REPOSITORY_URL>
    cd <DIRECTORY_NAME>
    ```

2. Install the dependencies:

    ```bash
    dart pub get
    ```

## Usage

### Run the Server

To start the server, use the following command:

```bash
dart run bin/local_mock_apirest.dart --port <PORT> --path <PATH_TO_YAML_FILE>
```

For example:

```bash
dart run bin/local_mock_apirest.dart --port 8080 --path ./mock.yaml
```

### YAML File

The YAML file should have the following structure:

```yaml
routes:
  - path: "/"
    method: "GET"
    response:
      status: 200
      body: "Hello, world!"
      time: 1000
      headers:
        - key: "Content-Type"
          value: "text/plain"
  - path: "/api"
    method: "POST"
    response:
      status: 201
      body: "{\"message\": \"Created\"}"
      time: 2000
      headers:
        - key: "Content-Type"
          value: "application/json"
  - path: "/error"
    method: "GET"
    response:
      status: 500
      body: "{\"message\": \"Internal Server Error\"}"
      time: 3000
      headers:
        - key: "Content-Type"
          value: "application/json"
```

### Automatic Restart

The server monitors the specified YAML file for changes. If the file is modified, the server stops and restarts automatically to load the new routes and responses.

### Stop the Server

The server will automatically stop and restart when the YAML file is changed. If you want to stop the server manually, you can do so by pressing `Ctrl+C` in the terminal.

## Development and Testing

### Unit Tests

This project includes unit tests to validate the server's behavior and the YAML file's validity.

To run the tests, use the following command:

```bash
dart test
```

### Project Structure

- `bin/local_mock_apirest.dart`: Server entry point.
- `lib/local_mock_apirest.dart`: Main server logic.
- `test/server_test.dart`: Unit tests for the server.
- `test/mock.yaml`: Test YAML file.

## Contributions

Contributions are welcome. Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
