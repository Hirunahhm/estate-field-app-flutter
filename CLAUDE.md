# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is **estate_field_app** — a Flutter application for Madukotawatte ERP estate field operations. It is currently in early/greenfield state (default Flutter template with no feature code yet).

- App name: `estate_field_app`
- Version: 1.0.0+1
- Dart SDK: ^3.9.2 (Flutter >=3.18.0)
- Supported platforms: Android, iOS, Windows

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run the app (debug)
flutter run

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage

# Analyze code (lint)
flutter analyze

# Format code
dart format lib/ test/

# Build
flutter build apk          # Android APK
flutter build appbundle    # Android App Bundle
flutter build ios          # iOS (requires macOS)
flutter build windows      # Windows
```

## Architecture

Currently a minimal Flutter starter. As features are built out, the expected structure for an ERP field app is:

```
lib/
├── main.dart              # App entry point; MaterialApp setup
├── features/              # Feature-first organization (recommended)
│   └── <feature>/
│       ├── data/          # Data sources, repositories, models
│       ├── domain/        # Business logic, entities
│       └── presentation/  # Widgets, screens, state management
├── core/                  # Shared utilities, constants, theme
└── shared/                # Reusable widgets
```

**State management**: No state management library is added yet. When adding one, update this file with the chosen approach (Riverpod, Bloc, Provider, etc.) and any conventions.

## Linting

Uses `package:flutter_lints/flutter.yaml` (default Flutter recommended rules). Custom rules can be added to `analysis_options.yaml`.
