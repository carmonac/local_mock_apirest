# Local Mock API REST

A local mock server that uses YAML files to define routes, methods, and responses. The server automatically restarts if the YAML file is modified.

## Installation

### Global Installation (Recommended)

To install the package globally and use it as a command-line tool:

```bash
dart pub global activate local_mock_apirest
```

## Requirements

- Dart SDK ^3.4.4

## Usage

### Run the Server

To start the server, use the following command:

```bash
local_mock_apirest --port <PORT> --path <PATH_TO_YAML_FILE>
```

For example:

```bash
local_mock_apirest --port 8080 --path ./mock.yaml
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

## Contributions

Contributions are welcome. Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
