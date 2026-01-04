# Reminder App

A cross-platform desktop reminder application built with Flutter for macOS and Linux.

## Features

- **One-time and recurring reminders** - Create reminders with daily, weekly, monthly, or yearly recurrence patterns
- **Categories/tags** - Organize reminders with color-coded categories
- **Priority levels** - Set high, medium, or low priority for each reminder
- **System notifications** - Native desktop notifications when reminders are due
- **In-app notification center** - View completed reminder history
- **Dark/light theme** - Switch between themes or follow system preference

## Tech Stack

- **Framework**: Flutter Desktop (3.22+)
- **Database**: SQLite via Drift ORM
- **State Management**: Riverpod 3.x with code generation
- **Notifications**: flutter_local_notifications
- **Window Management**: window_manager

## Getting Started

### Prerequisites

- Flutter SDK 3.22 or later
- Dart SDK 3.10 or later
- CocoaPods (for macOS)

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd reminder-dart-app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate code (Drift, Freezed, Riverpod):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. Run the app:
   ```bash
   # For macOS
   flutter run -d macos

   # For Linux
   flutter run -d linux
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app.dart                  # MaterialApp configuration
├── core/                     # Shared utilities
│   ├── constants/
│   ├── theme/
│   └── widgets/
├── database/                 # Drift database layer
│   ├── database.dart         # Main database class
│   └── tables/               # Table definitions
├── features/
│   ├── reminders/           # Reminder feature
│   ├── categories/          # Category management
│   ├── notifications/       # Notification center
│   ├── scheduler/           # Background reminder checking
│   └── settings/            # App settings
└── navigation/              # Routing with go_router
```

## Database Schema

The app uses SQLite with the following tables:
- **reminders** - Stores reminder details, due dates, recurrence rules
- **categories** - User-defined categories with colors
- **reminder_categories** - Junction table for many-to-many relationship
- **notification_log** - Tracks sent notifications

## Building for Production

```bash
# macOS
flutter build macos

# Linux
flutter build linux
```

## Configuration

The app automatically:
- Creates the database on first run with default categories
- Checks for due reminders every minute
- Shows system notifications for due reminders
- Generates next occurrences for recurring reminders

## License

This project is for personal use.
