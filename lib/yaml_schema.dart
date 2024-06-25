const String schemaJsonString = '''
  {
    "type": "object",
    "properties": {
      "routes": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "path": {"type": "string"},
            "method": {"type": "string"},
            "response": {
              "type": "object",
              "properties": {
                "status": {"type": "integer"},
                "body": {"type": "string"},
                "time": {"type": "integer"},
                "headers": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "properties": {
                      "key": {"type": "string"},
                      "value": {"type": "string"}
                    },
                    "required": ["key", "value"]
                  }
                }
              }
            }
          },
          "required": ["path", "method", "response"]
        }
      }
    },
    "required": ["routes"]
  }
  ''';
