# My App

A Flutter application designed for cross-platform development.

## Development Environment

This project uses Docker to provide a consistent development environment across all platforms.

### Prerequisites

- Docker
- Docker Compose

### Running the Application

#### Development Mode with Hot Reload

For the best development experience with Flutter's hot reload functionality:

1. Start the Docker container in interactive mode:
```bash
   docker compose run --service-ports flutter bash
```

2. Inside the container, install dependencies:
```bash
   flutter pub get
```

3. Launch the application:
```bash
   flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0
```

The application will be accessible at `http://localhost:8080`

## Project Structure

This project follows Flutter's standard application structure. For more information about organizing your Flutter project, refer to the [official documentation](https://docs.flutter.dev/).

## Resources

### New to Flutter?

- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab) - Step-by-step tutorial
- [Flutter Cookbook](https://docs.flutter.dev/cookbook) - Practical code samples
- [Flutter Documentation](https://docs.flutter.dev/) - Comprehensive guides and API reference

## Contributing

[Add your contribution guidelines here]

## License

[Add your license information here]



