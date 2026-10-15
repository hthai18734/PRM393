# PRM393 - LAB 4: Manage Recurring Bills APP

A Flutter application to manage recurring bills such as electricity, water, rent, internet, insurance, and subscriptions, with local SQLite storage (`sqflite`).

## Features
- **All Bills Screen (Home Screen)**:
  - Banner header (`Image.asset`)
  - List of all recurring bills showing Bill Name, Category, Amount, Due Date, and Status badge
  - Empty state when no bills exist
  - Floating Action Button (`+`) to add new bills
  - Tap any bill to navigate to its update screen
- **Add New Bill Screen**:
  - Input fields: Bill Name, Category dropdown, Amount, Due Date with DatePicker, Status (defaults to "Unpaid")
  - Input validation with immediate feedback dialog
  - Auto-inserts into SQLite and auto-refreshes Home Screen
  - Save and Back buttons
- **Update Bill Screen**:
  - Editable form pre-filled with existing bill information
  - Update, Delete, and Back buttons on the same row
  - Update saves changes to SQLite with success dialog
  - Delete with confirmation dialog ("Confirm Delete") and success alert
- **Unpaid Bills Summary Screen**:
  - Displays only bills with status = "Unpaid"
  - Summary header with unpaid bill counter
  - Outstanding Summary card calculating total unpaid bills and total outstanding amount (VND)
- **Bottom Tab Navigation**:
  - Easily switch between Home screen and Unpaid Bills Summary screen

## Tech Stack
- Flutter 3.x
- SQLite (`sqflite` & `sqflite_common_ffi` for desktop support)
- `intl` for currency (VND) and date formatting

## Getting Started
1. Install dependencies:
   ```bash
   flutter pub get
   ```
2. Run the application:
   ```bash
   # On Windows
   flutter run -d windows

   # On Android / iOS
   flutter run
   ```
3. Run tests:
   ```bash
   flutter test
   ```