# TrackIt Mobile App

**TrackIt** is a modern Flutter application designed to help users track daily financial transactions effortlessly. With TrackIt, users can manage income and expenses, visualize spending patterns, and gain insights into their finances through intuitive charts.

## Table of Contents

- [Features](#features)  
- [Screenshots](#screenshots)  
- [Project Structure](#project-structure)  
- [Getting Started](#getting-started)  
- [Installation](#installation)  
- [Usage](#usage)  
- [State Management](#state-management) 

## Features

- **Add, View, and Delete Transactions:** Keep track of income and expenses easily.  
- **Automatic Balance Calculation:** The app calculates your current balance in real-time.  
- **Visual Statistics:** Analyze your finances with intuitive charts and graphs.  
- **Filter by Date:** Quickly view transactions from specific dates or periods.  
- **Simple and Intuitive UI:** Modern design for easy navigation and interaction.  
- **State Management:** Powered by `Provider` for efficient and reactive state updates.  

## Screenshots

<img src="screenshot/trackit.png" alt="TrackIt UI" width="450"/>


## Getting Started

These instructions will help you set up the project locally for development and testing purposes.

### Prerequisites

- Flutter SDK >= 3.0.0  
- Dart >= 3.0.0  
- Android Studio or VS Code  
- Emulator or physical device for testing  

## Project Structure

```text
trackit/
│
├─ android/
├─ ios/
├─ lib/
│   ├─ main.dart
│   ├─ models/
│   │   └─ transaction.dart
│   ├─ providers/
│   │   └─ transaction_provider.dart
│   ├─ screens/
│   │   ├─ home_screen.dart
│   │   └─ add_transaction_screen.dart
│   ├─ widgets/
│   │   ├─ transaction_list.dart
│   │   └─ chart.dart
├─ screenshot/
│   └─ trackit.png
├─ pubspec.yaml
├─ README.md
└─ .gitignore
```

- **`lib/main.dart`**: Entry point of the app  
- **`lib/models/transaction.dart`**: Data model for transactions  
- **`lib/providers/transaction_provider.dart`**: State management using Provider  
- **`lib/screens/`**: Contains main screens of the app  
- **`lib/widgets/`**: Reusable UI components (list, chart)  

## Getting Started

These instructions will help you set up the project locally for development and testing purposes.

### Prerequisites

- Flutter SDK >= 3.0.0  
- Dart >= 3.0.0  
- Android Studio or VS Code  
- Emulator or physical device for testing  

### Installation

1. **Clone the repository:**  
```bash
git clone https://github.com/yourusername/trackit.git
cd trackit
```
2. **Install dependencies:**  
```bash
flutter pub get
```
3. **Run the app:**  
```bash
flutter run
```
## **Usage**

- Open the app on your device or emulator.  
- Add a new transaction by selecting **Income** or **Expense**.  
- View your transaction history on the home screen.  
- Check your financial summary and charts for insights.  
- Filter transactions by selecting a date range.  

## **State Management**

TrackIt uses **Provider** for state management:  

- Centralized state for transactions and balance calculation.  
- Reactive UI updates when transactions are added, updated, or deleted.  
- Easy scalability for future features.

A few resources to get you started if this is your first Flutter project: 
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.
