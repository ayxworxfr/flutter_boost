# Flutter Boost

[English](./README.md) | [简体中文](./README.zh-CN.md)

An out-of-box Flutter scaffold for enterprise applications.

[![Flutter](https://img.shields.io/badge/Flutter-3.19+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3+-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## ✨ Features

- 💡 **Dart 3.3+**: Latest Dart language features with strict type checking
- 📦 **Modular**: Feature-based modular architecture
- 🎨 **Theming**: Built-in light/dark theme support
- 🌐 **i18n**: Internationalization with GetX translations
- 🔧 **Best Practices**: Clean code patterns and lint rules
- 🧪 **Mock Data**: Development-friendly mock data system
- 📱 **Cross-Platform**: Android, iOS, Web, macOS, Windows, Linux

## 📐 Architecture

```
lib/
├── app/                    # App configuration
│   ├── bindings/           # Dependency bindings
│   ├── middlewares/        # Route middlewares
│   └── routes/             # Route definitions
├── core/                   # Core modules
│   ├── config/             # Configuration
│   ├── mock/               # Mock data
│   ├── network/            # HTTP client & interceptors
│   ├── storage/            # Local storage (Hive + SharedPreferences)
│   ├── theme/              # Theme configuration
│   ├── utils/              # Utilities
│   └── widgets/            # Common widgets
├── features/               # Feature modules
│   └── [feature]/
│       ├── bindings/       # Feature bindings
│       ├── controllers/    # GetX controllers
│       ├── models/         # Data models
│       ├── services/       # API services
│       └── views/          # UI pages
└── shared/                 # Shared resources
    ├── constants/          # Constants
    ├── translations/       # i18n files
    └── types/              # Type definitions
```

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| State Management | GetX 4.6.6 |
| Network | Dio 5.4.0 |
| Local Storage | Hive + SharedPreferences |
| UI Utils | ScreenUtil, CachedNetworkImage, Shimmer |
| Logging | Logger |

## 🚀 Quick Start

### Prerequisites

- Flutter >= 3.19.0
- Dart >= 3.3.0

### Installation

```bash
# Clone the repository
git clone https://github.com/your-org/flutter_boost.git
cd flutter_boost

# Install dependencies
make install

# Run the app
make run
```

### Development Credentials

| Field | Value |
|-------|-------|
| Username | `admin` |
| Password | `123456` |

> Note: Mock mode is enabled by default in development. Login will succeed with any credentials.

## 📝 Available Commands

```bash
make help          # Show all commands
make install       # Install dependencies
make run           # Run on Chrome
make run-web       # Run on Web (port 8080)
make build-web     # Build for Web
make analyze       # Analyze code
make format        # Format code
make test          # Run tests
make clean         # Clean build files
make stop          # Stop running app
```

## 🌍 Internationalization

Supports Chinese and English with structured key naming:

```dart
// Key format: category.page.element
'pages.login.title'.tr           // "Login"
'common.confirm'.tr              // "Confirm"
'validation.email.invalid'.tr   // "Invalid email"
```

## 🔧 Configuration

### Environment Config

Located in `lib/core/config/env_config.dart`:

```dart
EnvConfig.apiBaseUrl    // API base URL
EnvConfig.enableMock    // Enable mock data
EnvConfig.enableLog     // Enable logging
```

### App Config

Located in `lib/core/config/app_config.dart`:

```dart
AppConfig.defaultPadding       // 16.0
AppConfig.defaultAnimationDuration   // 300ms
AppConfig.defaultPageSize      // 20
```

## 📚 Documentation

- [Architecture Design](docs/Flutter架构设计文档.md)
- [Contributing Guide](CONTRIBUTING.md)

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) first.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Built with ❤️ by Flutter Boost Team**
