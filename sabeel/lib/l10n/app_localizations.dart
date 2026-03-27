import 'package:flutter/material.dart';

/// Lightweight custom localisation supporting EN, FR, AR.
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // ── Lookup table ────────────────────────────────────────
  static final Map<String, Map<String, String>> _values = {
    'en': {
      'appTitle': 'Prayer Times',
      'home': 'Home',
      'adhkar': 'Adhkar',
      'settings': 'Settings',
      'fajr': 'Fajr',
      'sunrise': 'Sunrise',
      'dhuhr': 'Dhuhr',
      'asr': 'Asr',
      'maghrib': 'Maghrib',
      'isha': 'Isha',
      'nextPrayer': 'Next Prayer',
      'timeRemaining': 'Time Remaining',
      'noLocation': 'No location set',
      'tapToSetLocation': 'Tap to set your location',
      'language': 'Language',
      'theme': 'Theme',
      'lightMode': 'Light',
      'darkMode': 'Dark',
      'calculationMethod': 'Calculation Method',
      'madhab': 'Madhab (Asr)',
      'shafi': 'Shafi\'i / Maliki / Hanbali',
      'hanafi': 'Hanafi',
      'location': 'Location',
      'useGPS': 'Use GPS',
      'manualLocation': 'Manual Location',
      'latitude': 'Latitude',
      'longitude': 'Longitude',
      'cityName': 'City Name',
      'save': 'Save',
      'cancel': 'Cancel',
      'adjustments': 'Prayer Time Adjustments (minutes)',
      'prayerNotifications': 'Prayer Notifications',
      'morningAdhkar': 'Morning Adhkar',
      'eveningAdhkar': 'Evening Adhkar',
      'afterPrayerAdhkar': 'After Prayer Adhkar',
      'repeat': 'Repeat',
      'times': 'times',
      'getLocation': 'Get Location',
      'locationUpdated': 'Location updated',
      'enterManualLocation': 'Enter Manual Location',
      'english': 'English',
      'french': 'French',
      'arabic': 'Arabic',
      'muslimWorldLeague': 'Muslim World League',
      'egyptian': 'Egyptian General Authority',
      'karachi': 'University of Islamic Sciences, Karachi',
      'ummAlQura': 'Umm al-Qura University, Makkah',
      'dubai': 'Dubai',
      'northAmerica': 'ISNA (North America)',
      'kuwait': 'Kuwait',
      'qatar': 'Qatar',
      'singapore': 'Singapore',
      'turkey': 'Turkey',
      'tehran': 'Tehran',
      'allPrayersOver': 'All prayers for today have passed',
      'tomorrowFajr': 'Tomorrow\'s Fajr',
    },
    'fr': {
      'appTitle': 'Heures de Prière',
      'home': 'Accueil',
      'adhkar': 'Adhkar',
      'settings': 'Paramètres',
      'fajr': 'Fajr',
      'sunrise': 'Lever du soleil',
      'dhuhr': 'Dhuhr',
      'asr': 'Asr',
      'maghrib': 'Maghrib',
      'isha': 'Isha',
      'nextPrayer': 'Prière suivante',
      'timeRemaining': 'Temps restant',
      'noLocation': 'Aucun emplacement défini',
      'tapToSetLocation': 'Appuyez pour définir votre emplacement',
      'language': 'Langue',
      'theme': 'Thème',
      'lightMode': 'Clair',
      'darkMode': 'Sombre',
      'calculationMethod': 'Méthode de calcul',
      'madhab': 'Madhab (Asr)',
      'shafi': 'Shafi\'i / Maliki / Hanbali',
      'hanafi': 'Hanafi',
      'location': 'Emplacement',
      'useGPS': 'Utiliser le GPS',
      'manualLocation': 'Emplacement manuel',
      'latitude': 'Latitude',
      'longitude': 'Longitude',
      'cityName': 'Nom de la ville',
      'save': 'Enregistrer',
      'cancel': 'Annuler',
      'adjustments': 'Ajustements des heures (minutes)',
      'prayerNotifications': 'Notifications de prière',
      'morningAdhkar': 'Adhkar du Matin',
      'eveningAdhkar': 'Adhkar du Soir',
      'afterPrayerAdhkar': 'Adhkar après la Prière',
      'repeat': 'Répéter',
      'times': 'fois',
      'getLocation': 'Obtenir l\'emplacement',
      'locationUpdated': 'Emplacement mis à jour',
      'enterManualLocation': 'Entrer l\'emplacement manuellement',
      'english': 'Anglais',
      'french': 'Français',
      'arabic': 'Arabe',
      'muslimWorldLeague': 'Ligue Islamique Mondiale',
      'egyptian': 'Autorité Générale Égyptienne',
      'karachi': 'Université des Sciences Islamiques, Karachi',
      'ummAlQura': 'Université Umm al-Qura, La Mecque',
      'dubai': 'Dubaï',
      'northAmerica': 'ISNA (Amérique du Nord)',
      'kuwait': 'Koweït',
      'qatar': 'Qatar',
      'singapore': 'Singapour',
      'turkey': 'Turquie',
      'tehran': 'Téhéran',
      'allPrayersOver': 'Toutes les prières d\'aujourd\'hui sont passées',
      'tomorrowFajr': 'Fajr de demain',
    },
    'ar': {
      'appTitle': 'مواقيت الصلاة',
      'home': 'الرئيسية',
      'adhkar': 'أذكار',
      'settings': 'الإعدادات',
      'fajr': 'الفجر',
      'sunrise': 'الشروق',
      'dhuhr': 'الظهر',
      'asr': 'العصر',
      'maghrib': 'المغرب',
      'isha': 'العشاء',
      'nextPrayer': 'الصلاة القادمة',
      'timeRemaining': 'الوقت المتبقي',
      'noLocation': 'لم يتم تحديد الموقع',
      'tapToSetLocation': 'اضغط لتحديد موقعك',
      'language': 'اللغة',
      'theme': 'المظهر',
      'lightMode': 'فاتح',
      'darkMode': 'داكن',
      'calculationMethod': 'طريقة الحساب',
      'madhab': 'المذهب (العصر)',
      'shafi': 'شافعي / مالكي / حنبلي',
      'hanafi': 'حنفي',
      'location': 'الموقع',
      'useGPS': 'استخدام GPS',
      'manualLocation': 'إدخال يدوي',
      'latitude': 'خط العرض',
      'longitude': 'خط الطول',
      'cityName': 'اسم المدينة',
      'save': 'حفظ',
      'cancel': 'إلغاء',
      'adjustments': 'تعديل المواقيت (بالدقائق)',
      'prayerNotifications': 'إشعارات الصلاة',
      'morningAdhkar': 'أذكار الصباح',
      'eveningAdhkar': 'أذكار المساء',
      'afterPrayerAdhkar': 'أذكار بعد الصلاة',
      'repeat': 'التكرار',
      'times': 'مرات',
      'getLocation': 'تحديد الموقع',
      'locationUpdated': 'تم تحديث الموقع',
      'enterManualLocation': 'إدخال الموقع يدوياً',
      'english': 'الإنجليزية',
      'french': 'الفرنسية',
      'arabic': 'العربية',
      'muslimWorldLeague': 'رابطة العالم الإسلامي',
      'egyptian': 'الهيئة المصرية العامة للمساحة',
      'karachi': 'جامعة العلوم الإسلامية، كراتشي',
      'ummAlQura': 'جامعة أم القرى، مكة',
      'dubai': 'دبي',
      'northAmerica': 'أمريكا الشمالية (ISNA)',
      'kuwait': 'الكويت',
      'qatar': 'قطر',
      'singapore': 'سنغافورة',
      'turkey': 'تركيا',
      'tehran': 'طهران',
      'allPrayersOver': 'انتهت جميع صلوات اليوم',
      'tomorrowFajr': 'فجر الغد',
    },
  };

  String tr(String key) {
    return _values[locale.languageCode]?[key] ??
        _values['en']?[key] ??
        key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'fr', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}