# 🕌 Sabeel - Muslim Adhan & Prayer Times App

Sabeel (سبيل) is a beautifully designed, feature-rich Flutter application crafted to help Muslims worldwide keep track of their daily prayers. It provides accurate prayer times, smart city search, exact Adhan notifications, and a dynamic home screen widget.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)

## ✨ Key Features

* **📍 Smart Location & City Search:** Automatically detect your location via GPS, or manually search for any city worldwide using the integrated smart search (No GPS required).
* **⏰ Accurate Prayer Times:** Highly customizable prayer calculation methods and Madhab settings to match your local region's standards.
* **🔔 Exact Adhan Notifications:** Reliable background alarms that play the Adhan exactly on time, optimized for modern Android background restrictions.
* **📌 Persistent "Next Prayer" Notification:** A silent, ongoing notification to keep you updated on the upcoming prayer time without opening the app.
* **📱 Dynamic Home Screen Widget:** A beautifully styled Android widget that auto-refreshes to show today's prayer schedule right on your home screen.
* **🌗 Dark & Light Mode:** Seamless theme switching for comfortable day and night reading.
* **🌐 Multi-language Support:** Available in Arabic, English, and French.

## 🛠️ Tech Stack & Packages

This project leverages the power of Flutter and several key packages:

* **State Management:** `flutter_riverpod` for clean and reactive state management.
* **Notifications:** `flutter_local_notifications` for background alarms and persistent notifications.
* **Location Services:** `geolocator` & `geocoding` for GPS and smart city lookup.
* **Home Widget:** `home_widget` for native Android widget integration.
* **Background Tasks:** `workmanager` for scheduled background syncs.

## 🚀 Getting Started

To build and run this project on your local machine, follow these steps:

### Prerequisites
* Flutter SDK (Latest stable version recommended)
* Android Studio / VS Code
* Java 17 (Required for modern Gradle builds)

### Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/ysnlb/Sabeel-Muslim-Adhan-App.git](https://github.com/ysnlb/Sabeel-Muslim-Adhan-App.git)
    cd Sabeel-Muslim-Adhan-App/sabeel
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    ```bash
    flutter run
    ```

### Building for Release (Android)
To generate an optimized release APK (with ProGuard rules applied to prevent notification crashes):
```bash
flutter clean
flutter build apk --release
