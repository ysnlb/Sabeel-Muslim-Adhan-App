# Sabeel-Muslim-Adhan-App 🕌

[span_0](start_span)A clean, modern, and production-ready Flutter application for Muslim prayer times and daily Adhkar, heavily inspired by the "Mawaqit" app[span_0](end_span). Built with a focus on simplicity, performance, and professional UI.

## 🌟 Features

* **[span_1](start_span)[span_2](start_span)[span_3](start_span)Accurate Prayer Times:** Calculates prayer times automatically based on location (GPS) or manual entry using the `adhan_dart` package[span_1](end_span)[span_2](end_span)[span_3](end_span).
* **[span_4](start_span)[span_5](start_span)[span_6](start_span)Adhkar Collection:** Includes Morning, Evening, and After-Prayer Adhkar with Arabic text, translations (English/French), and repetition counters[span_4](end_span)[span_5](end_span)[span_6](end_span).
* **[span_7](start_span)[span_8](start_span)Advanced Notifications:** * Exact-time Adhan push notifications with custom audio (`adhan.mp3`)[span_7](end_span)[span_8](end_span).
  * [span_9](start_span)A silent, persistent ongoing notification displaying the next prayer and its time[span_9](end_span).
* **[span_10](start_span)[span_11](start_span)Home Screen Widget:** An Android home widget displaying the daily prayer schedule, automatically updated in the background[span_10](end_span)[span_11](end_span).
* **Customization & Settings:**
  * [span_12](start_span)[span_13](start_span)Adjust prayer times manually (+/- minutes)[span_12](end_span)[span_13](end_span).
  * [span_14](start_span)[span_15](start_span)Change calculation methods (Muslim World League, Egyptian, etc.) and Madhab[span_14](end_span)[span_15](end_span).
  * [span_16](start_span)[span_17](start_span)Full Dark Mode and Light Mode support[span_16](end_span)[span_17](end_span).
* **[span_18](start_span)Localization:** Fully supports 3 languages: English, French, and Arabic (with complete RTL support)[span_18](end_span).
* **[span_19](start_span)[span_20](start_span)Background Sync:** Uses `workmanager` to recalculate times and update widgets/notifications seamlessly in the background[span_19](end_span)[span_20](end_span).

## 🛠️ Tech Stack

* **[span_21](start_span)Framework:** Flutter / Dart[span_21](end_span)
* **[span_22](start_span)[span_23](start_span)State Management:** Riverpod[span_22](end_span)[span_23](end_span)
* **[span_24](start_span)[span_25](start_span)Local Storage:** SharedPreferences[span_24](end_span)[span_25](end_span)
* **[span_26](start_span)[span_27](start_span)Background Tasks:** Workmanager[span_26](end_span)[span_27](end_span)
* **[span_28](start_span)[span_29](start_span)Notifications:** flutter_local_notifications[span_28](end_span)[span_29](end_span)
* **[span_30](start_span)[span_31](start_span)Home Widget:** home_widget[span_30](end_span)[span_31](end_span)
* **[span_32](start_span)[span_33](start_span)Calculations:** adhan_dart[span_32](end_span)[span_33](end_span)

## 🚀 Getting Started

### Prerequisites
* [span_34](start_span)Flutter SDK (`>=3.0.0 <4.0.0`)[span_34](end_span)
* Android Studio / VS Code (or GitHub Codespaces)

### Installation

1. **Clone the repository** (https://github.com/ysnlb/Sabeel-Muslim-Adhan-App.git).
2. **Install dependencies:**
   ```bash
   flutter pub get
   
