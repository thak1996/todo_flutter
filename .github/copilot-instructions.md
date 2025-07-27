# Copilot Instructions for AI Coding Agents

## Project Overview

This is a Flutter application using Firebase Auth and Firestore for authentication and todo management. The architecture is modular, with separation of concerns for models, services, exceptions, state management (Cubit/BLoC), and UI components.

## Folder Structure

- `lib/core/`: Shared models, services, exceptions, interfaces, extensions.
- `lib/app/`: App-level providers, localization, routing, shared widgets.
- `lib/app/page/`: Main pages (home, login, register, etc.).
- `lib/app/shared/`: Reusable UI components.
- `features/`: Feature-specific logic (auth, todo, group).
- `android/`, `ios/`: Platform-specific code.

## Key Technologies

- **Dart/Flutter**: UI, logic, state management.
- **Firebase Auth**: User authentication.
- **Firestore**: Todo and group data storage.
- **result_dart (AsyncResult)**: Functional error handling.
- **Cubit/BLoC**: State management.
- **GoRouter**: Routing and route guards.
- **l10n**: Localization.

## Coding Conventions

- Use custom exceptions for error handling (`AppException`, enums, factory constructors).
- State separation: User, todos, groups, and errors are managed independently in Cubit states.
- Use extension methods for error messages and utility functions.
- UI composition: Dialogs for adding todos, BlocSelector for extracting state.
- Firestore: Handle date fields carefully (int/string conversion).
- Route guards: Use GoRouter with custom redirect logic for public/protected routes.

## Workflow Guidance

- Always emit new states after async operations (e.g., after adding a todo).
- Use helper functions to retrieve valid user info from state.
- Place BlocProvider at the top level to preserve state across navigation.
- For new features, create models, services (with AsyncResult), and UI components in their respective folders.
- For error handling, prefer custom exceptions and localized messages.

## Onboarding Steps for AI Agents

1. Follow the modular folder structure for new code.
2. Use Cubit/BLoC for state management; keep states separated for user, todos, groups.
3. Integrate with Firebase Auth/Firestore using existing service patterns.
4. Use extension methods and localization for error messages.
5. Update routing logic in `app.router.dart` for new pages or route guards.
6. Add new UI components to `shared/widgets` or feature folders as appropriate.
7. Ensure all async operations return `AsyncResult` and handle errors gracefully.
8. Write tests for new services and models.

## References

- See `README.md` for basic Flutter setup.
- See `lib/core/` and `lib/app/` for architecture examples.
- Use official Flutter and Firebase documentation for platform-specific issues.

---

For questions or improvements, follow project conventions and update this file as needed.
