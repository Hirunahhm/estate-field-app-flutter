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

This project strictly follows a **Feature-First Clean Architecture**:

```
lib/
├── core/                  # Global utilities, themes, constants & shared components
├── features/              # Feature modules
│   ├── auth/              # Login Screen
│   ├── home/              # Dashboard
│   ├── hr/                # Tapper Attendance
│   ├── production/        # Latex Collection & Record Trees
│   ├── lab/               # Metrolac Quality Update
│   └── finance/           # Expenses & Sales
└── main.dart              # Entry point & global config
```
Each feature MUST contain `data/`, `domain/`, and `presentation/` layers where applicable. 

**State management**: We use **Flutter Riverpod**.
- Use `AsyncNotifier` or `StateNotifier` for UI state. 
- Do not map complex state using `setState()`.
- Place providers in `lib/features/[feature]/presentation/providers/`.

## Design System & Translating HTML
- **Colors**: Use `AppColors` derived from the mockups (Primary: `#37ec13`, BackgroundDark: `#132210`, SurfaceDark: `#1e3319`). Do not hardcode colors in widgets.
- **Typography**: Strictly use `GoogleFonts.inter()`.
- **Icons**: Use the `material_symbols_icons` package.

## Linting

Uses `package:flutter_lints/flutter.yaml`. Add custom rules to `analysis_options.yaml` as needed.
