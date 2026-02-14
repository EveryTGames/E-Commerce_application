# ShopCraft

A Flutter learning project demonstrating modern Flutter development practices and libraries. This application showcases an e-commerce interface with authentication, localization, and responsive design.

## Overview

ShopCraft is a comprehensive Flutter application built to explore and implement advanced Flutter concepts and libraries. The app features a complete authentication flow, multi-language support, dynamic theming, and a product showcase interface.

**Note:** This application is not connected to an actual database and is designed for learning and demonstration purposes.

## Default Credentials

For testing the login functionality, use the following default credentials:
- Email: `test@example.com`
- Password: `1234`

## Key Features

### Authentication System
- Landing screen with options to login or signup
- Login and signup screens with form validation
- Authentication state management using Riverpod
- Secure credential handling (hardcoded credentials for demo purposes)

### Multi-Language Support
- Built-in localization for multiple languages
- Language switching without app restart
- Supports Arabic and English locales
- Uses Flutter's localization framework

### Navigation & Routing
- GoRouter for declarative routing and deep linking support
- Shell routes with persistent UI elements
- Back navigation with back button support
- Automatic route management based on authentication state

### Theme & UI
- Dark mode and light mode toggle
- Gradient backgrounds
- Responsive design with auto-scaling text
- Cached network image support for product displays
- Custom animated button widgets

### State Management
- Flutter Riverpod for state management
- AsyncNotifier for handling async operations
- StateProvider for simple state mutations
- Provider for computed values

## Project Structure

`` `
lib/
 main.dart                 # Entry point and router configuration
 landing_screen.dart       # Initial landing page
 login_screen.dart         # Login authentication screen
 signup_screen.dart        # Registration screen
 home_screen.dart          # Main product showcase screen
 error_screen.dart         # Error handling display
 input_provider.dart       # Input field state management
 for_reverpod.dart         # Riverpod provider definitions
 utils.dart                # Reusable UI components and utilities
 l10n/                     # Localization files
    app_en.arb           # English translations
    app_ar.arb           # Arabic translations
    app_localizations.dart
    app_localizations_en.dart
    app_localizations_ar.dart
 assets/                   # Application assets
`` `

## Technologies & Dependencies

### Core Framework
- Flutter 3.10.0 and above
- Dart 3.10.0 and above

### Key Dependencies
- **flutter_riverpod**: Advanced state management solution
- **go_router**: Declarative routing and deep linking
- **flutter_localizations**: Multi-language support
- **intl**: Internationalization and localization
- **cached_network_image**: Network image caching
- **auto_size_text**: Responsive text scaling
- **cupertino_icons**: iOS-style icon pack

### Development Tools
- flutter_lints: Code quality and best practices
- riverpod_lint: Riverpod-specific linting

## Getting Started

### Prerequisites
- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.10.0 or higher)
- A supported IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. Clone the repository
`` `bash
git clone <repository-url>
cd flutter_projects
`` `

2. Get dependencies
`` `bash
flutter pub get
`` `

3. Generate localization files
`` `bash
flutter gen-l10n
`` `

4. Run the application
`` `bash
flutter run
`` `

## Running on Different Platforms

### Android
`` `bash
flutter run -d android
`` `

### iOS
`` `bash
flutter run -d ios
`` `

### Web
`` `bash
flutter run -d web
`` `

### Windows
`` `bash
flutter run -d windows
`` `

## Project Features Explained

### Authentication Flow
The app implements a complete authentication flow with two states:
- Unauthenticated: User can only access landing, login, and signup screens
- Authenticated: User can access the home screen with products

### Home Screen
The home screen displays:
- Featured product collections with images
- Product listings with details
- Integration with network images for dynamic content

### Localization
Easily switch between English and Arabic languages:
- Language preference persists during session
- All UI text supports both languages
- RTL support for Arabic language

### Theme Toggle
Switch between light and dark themes:
- Located in the top-right corner
- Theme preference persists during session
- Smooth transitions between modes

## Code Highlights

### Riverpod Providers
`` `dart
final authProvider = StateProvider<bool>((ref) => true);
final localProvider = StateProvider<Locale>((ref) {
  return const Locale('en');
});
final routerProvider = Provider<GoRouter>((ref) { ... });
`` `

### GoRouter Configuration
The app uses GoRouter with redirect logic to manage navigation based on authentication state, ensuring users cannot access protected routes without logging in.

### Custom Widgets
- `AnimatedTextButton`: Custom button with state-based color changes
- Responsive text components
- Gradient backgrounds


## Notes

- This is a learning project demonstrating Flutter best practices
- No sensitive data should be stored in production using this pattern
- The hardcoded credentials are for demonstration only
- Network images are loaded from Unsplash API

## License

This project is provided as-is for educational purposes.
