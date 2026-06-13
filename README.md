# Satish Chits

A Flutter-based Chit Fund Management Application designed to simplify the management of chit groups, members, auctions, payments, and reports.

## Features

### Admin Features
- Admin Login
- Change Admin Password
- Manage Chit Groups
- Add/Edit/Delete Members
- Manage Auctions
- Auction History Tracking
- Generate Reports
- Clear Auction History (Admin Only)

### Member Management
- Add New Members
- Edit Member Details
- Remove Members
- Track Member Contributions

### Auction Management
- Conduct Auctions
- Record Winning Bids
- View Auction History
- Store Auction Records

### Payment Tracking
- Record Payments
- View Payment History
- Track Pending Payments

### Reports
- Group-wise Reports
- Member-wise Reports
- Auction Reports
- Payment Reports

### QR Code Support
- QR-based Member Identification
- Fast Member Lookup

### Local Storage
- Hive Database Integration
- Offline Functionality
- Fast Data Access

## Technology Stack

- Flutter
- Dart
- Hive Database
- Material Design

## Project Structure

```
lib/
├── models/
├── screens/
├── services/
├── widgets/
├── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Android SDK
- Xcode (for iOS development)

### Installation

1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/satish-chits.git
```

2. Navigate to project directory

```bash
cd satish-chits
```

3. Install dependencies

```bash
flutter pub get
```

4. Run the application

```bash
flutter run
```

## Build APK

```bash
flutter build apk --release
```

## Build App Bundle

```bash
flutter build appbundle --release
```

## Build iOS

```bash
flutter build ios --release
```

## Data Storage

This application uses Hive local database for storing:

- Admin Settings
- Chit Groups
- Members
- Auctions
- Payments
- Reports

## Future Enhancements

- Cloud Backup
- Excel Import/Export
- PDF Reports
- SMS Notifications
- WhatsApp Integration
- Multi-Admin Support
- Firebase Sync
- Online Backup

## Author

Srikanth Gangishetty

## License

This project is for educational and business use.
