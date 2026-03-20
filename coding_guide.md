# Estate ERP Field - Industrial Coding Guide

This guide defines the standards and architecture for the **Estate ERP Field** project to ensure scalability, maintainability, and professional delivery.

## 1. Architecture: Feature-First Clean Architecture
We follow a **Feature-First** structure combined with **Clean Architecture** layers. Each feature is a self-contained module.

### Directory Structure
```text
lib/
├── core/                  # Global utilities, themes, & shared components
│   ├── theme/             # AppColors, AppTheme
│   ├── constants/         # API endpoints, string constants
│   └── widgets/           # Reusable UI components (buttons, textfields)
├── features/              # Modular features
│   ├── auth/              # Login Screen
│   ├── home/              # Dashboard (Home Hub)
│   ├── hr/                # Tapper Attendance & Selection
│   ├── production/        # Latex Collection & Record Trees
│   ├── lab/               # Metrolac Quality Update
│   └── finance/           # Expenses & Sales
└── main.dart              # Entry point & global config
```

## 2. State Management: Riverpod
We use **Flutter Riverpod** (2.x+) for state management.
- **Providers**: Use `FutureProvider` for API calls and `StateNotifier` or `Notifier` for UI state.
- **Reactivity**: Keep UI logic inside providers to keep widgets pure and testable.
- **Dependency Injection**: Use providers as the DI mechanism for repositories and services.

## 3. UI & Theming (Standard Assets)
- **Typography**: Strictly use the **Inter** font family for all text.
- **Icons**: Use `material_symbols_icons` package (Material Symbols Outlined) to match the HTML mockups.
- **Design System**: Strictly follow the theme derived from the HTML mockups.
  - **Primary**: `#37ec13` (Green)
  - **Background Light**: `#f6f8f6`
  - **Background Dark**: `#132210`
  - **Surface Dark**: `#1e3319` and `#1a2e16`
  - **Surface Border**: `#294823`
  - **Surface Dark Highlight**: `#233d1e`
  - **Action Red**: `#EF4444` (For critical actions like Expenses)
- **Material 3**: Use Flutter's `ThemeData` with Material 3 enabled, utilizing custom `ColorScheme`.
- **Responsive Layout**: Build for mobile-first with safe-area paddings and flexible containers, avoiding hard-coded heights where possible.

## 4. Coding Standards
- **Lints**: Use `flutter_lints` or `very_good_analysis` for strict rule enforcement.
- **SOLID Principles**: Ensure each class has a single responsibility.
- **Naming Conventions**:
  - `camelCase` for variables and functions.
  - `PascalCase` for classes and widgets.
  - `snake_case` for files.
- **Async/Await**: Always use `async/await` instead of `.then()` for readability.
- **Error Handling**: Use `Result` patterns or `Either` type (from `fpdart` or custom) to handle errors gracefully without crashing.

## 5. Network & Persistence
- **HTTP Client**: Use `dio` for network requests (supports interceptors, global config).
- **Local Storage**: Use `flutter_secure_storage` for credentials and `hive` or `isar` for offline data synchronization.

## 6. Testing Strategy
- **Unit Tests**: Mandatory for business logic in `domain/` and [data/](file:///e:/Porjects/Madukotawatte%20ERP/estate-field-app-flutter/.metadata) layers.
- **Widget Tests**: For critical UI components and flows.
- **Golden Tests**: (Optional) To ensure pixel-perfect consistency across versions.

## 7. Version Control (Git)
- **Branching**: `main` (stable), `develop` (feature integration), `feature/*` (individual tasks).
- **Commits**: Follow [Conventional Commits](https://www.conventionalcommits.org/) (e.g., `feat: login screen implementation`).
