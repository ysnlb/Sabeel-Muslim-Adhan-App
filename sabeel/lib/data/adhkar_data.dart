import '../models/models.dart';

/// Static Adhkar data: Morning, Evening, and After-Prayer.
class AdhkarRepository {
  static const List<AdhkarCategory> categories = [
    // ── Morning Adhkar ──────────────────────────────────────
    AdhkarCategory(
      keyEn: 'Morning Adhkar',
      keyFr: 'Adhkar du Matin',
      keyAr: 'أذكار الصباح',
      items: [
        AdhkarItem(
          arabicText:
              'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ.',
          translationEn:
              'We have reached the morning and at this very time all sovereignty belongs to Allah. All praise is for Allah. None has the right to be worshipped except Allah, alone, without partner.',
          translationFr:
              'Nous voici au matin et le royaume appartient à Allah. Louange à Allah. Nul ne mérite d\'être adoré sauf Allah, Unique, sans associé.',
          repeatCount: 1,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText:
              'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ.',
          translationEn:
              'O Allah, by Your leave we have reached the morning, and by Your leave we reach the evening. By Your leave we live and die, and unto You is the resurrection.',
          translationFr:
              'Ô Allah, c\'est par Toi que nous atteignons le matin et le soir. Par Toi nous vivons et mourons, et vers Toi est la résurrection.',
          repeatCount: 1,
          reference: 'At-Tirmidhi',
        ),
        AdhkarItem(
          arabicText: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.',
          translationEn: 'Glory is to Allah and praise is to Him.',
          translationFr: 'Gloire et louange à Allah.',
          repeatCount: 100,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText: 'لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ.',
          translationEn:
              'None has the right to be worshipped except Allah, alone, without partner. To Him belongs all sovereignty and praise, and He is over all things omnipotent.',
          translationFr:
              'Nul ne mérite d\'être adoré sauf Allah, Seul, sans associé. À Lui la royauté, à Lui la louange, et Il est Omnipotent.',
          repeatCount: 10,
          reference: 'Bukhari & Muslim',
        ),
        AdhkarItem(
          arabicText:
              'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ.',
          translationEn:
              'O Allah, I ask You for well-being in this world and in the Hereafter.',
          translationFr:
              'Ô Allah, je Te demande le bien-être dans ce monde et dans l\'au-delà.',
          repeatCount: 3,
          reference: 'Abu Dawud & Ibn Majah',
        ),
        AdhkarItem(
          arabicText:
              'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ.',
          translationEn:
              'In the name of Allah, with Whose name nothing on earth or in heaven can cause harm, and He is the All-Hearing, the All-Knowing.',
          translationFr:
              'Au nom d\'Allah, par le nom duquel rien sur terre ni au ciel ne peut nuire, et Il est l\'Audient, l\'Omniscient.',
          repeatCount: 3,
          reference: 'Abu Dawud & At-Tirmidhi',
        ),
        AdhkarItem(
          arabicText:
              'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَٰهَ إِلَّا أَنْتَ.',
          translationEn:
              'O Allah, grant my body health. O Allah, grant my hearing health. O Allah, grant my sight health. None has the right to be worshipped except You.',
          translationFr:
              'Ô Allah, accorde la santé à mon corps. Ô Allah, accorde la santé à mon ouïe. Ô Allah, accorde la santé à ma vue. Nul ne mérite d\'être adoré sauf Toi.',
          repeatCount: 3,
          reference: 'Abu Dawud',
        ),
        AdhkarItem(
          arabicText:
              'حَسْبِيَ اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ.',
          translationEn:
              'Allah is sufficient for me. None has the right to be worshipped but He. In Him I put my trust and He is Lord of the Mighty Throne.',
          translationFr:
              'Allah me suffit. Nul ne mérite d\'être adoré sauf Lui. En Lui je place ma confiance et Il est le Seigneur du Trône immense.',
          repeatCount: 7,
          reference: 'Abu Dawud',
        ),
      ],
    ),

    // ── Evening Adhkar ──────────────────────────────────────
    AdhkarCategory(
      keyEn: 'Evening Adhkar',
      keyFr: 'Adhkar du Soir',
      keyAr: 'أذكار المساء',
      items: [
        AdhkarItem(
          arabicText:
              'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ.',
          translationEn:
              'We have reached the evening and at this very time all sovereignty belongs to Allah.',
          translationFr:
              'Nous voici au soir et le royaume appartient à Allah.',
          repeatCount: 1,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText:
              'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ.',
          translationEn:
              'O Allah, by Your leave we have reached the evening, and by Your leave we reach the morning. By Your leave we live and die, and unto You is the final return.',
          translationFr:
              'Ô Allah, c\'est par Toi que nous atteignons le soir et le matin. Par Toi nous vivons et mourons, et vers Toi est le retour final.',
          repeatCount: 1,
          reference: 'At-Tirmidhi',
        ),
        AdhkarItem(
          arabicText:
              'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ.',
          translationEn:
              'I seek refuge in the perfect words of Allah from the evil of that which He has created.',
          translationFr:
              'Je cherche refuge dans les paroles parfaites d\'Allah contre le mal de ce qu\'Il a créé.',
          repeatCount: 3,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.',
          translationEn: 'Glory is to Allah and praise is to Him.',
          translationFr: 'Gloire et louange à Allah.',
          repeatCount: 100,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ.',
          translationEn: 'I seek the forgiveness of Allah and repent to Him.',
          translationFr:
              'Je demande pardon à Allah et me repens auprès de Lui.',
          repeatCount: 100,
          reference: 'Bukhari & Muslim',
        ),
        AdhkarItem(
          arabicText:
              'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ.',
          translationEn:
              'O Allah, I seek refuge in You from anxiety and sorrow, from weakness and laziness.',
          translationFr:
              'Ô Allah, je cherche refuge auprès de Toi contre l\'anxiété et le chagrin, la faiblesse et la paresse.',
          repeatCount: 3,
          reference: 'Bukhari',
        ),
      ],
    ),

    // ── After-Prayer Adhkar ─────────────────────────────────
    AdhkarCategory(
      keyEn: 'After Prayer Adhkar',
      keyFr: 'Adhkar après la Prière',
      keyAr: 'أذكار بعد الصلاة',
      items: [
        AdhkarItem(
          arabicText: 'أَسْتَغْفِرُ اللَّهَ.',
          translationEn: 'I seek the forgiveness of Allah.',
          translationFr: 'Je demande pardon à Allah.',
          repeatCount: 3,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText:
              'اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ.',
          translationEn:
              'O Allah, You are Peace and from You is peace. Blessed are You, O Possessor of Majesty and Honour.',
          translationFr:
              'Ô Allah, Tu es la Paix et de Toi vient la paix. Béni sois-Tu, ô Détenteur de la Majesté et de la Générosité.',
          repeatCount: 1,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText: 'سُبْحَانَ اللَّهِ.',
          translationEn: 'Glory is to Allah.',
          translationFr: 'Gloire à Allah.',
          repeatCount: 33,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText: 'الْحَمْدُ لِلَّهِ.',
          translationEn: 'Praise is to Allah.',
          translationFr: 'Louange à Allah.',
          repeatCount: 33,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText: 'اللَّهُ أَكْبَرُ.',
          translationEn: 'Allah is the Greatest.',
          translationFr: 'Allah est le Plus Grand.',
          repeatCount: 33,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText:
              'لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ.',
          translationEn:
              'None has the right to be worshipped except Allah, alone, without partner. To Him belongs all sovereignty and praise and He is over all things omnipotent.',
          translationFr:
              'Nul ne mérite d\'être adoré sauf Allah, Seul, sans associé. À Lui la royauté, à Lui la louange, et Il est Omnipotent.',
          repeatCount: 1,
          reference: 'Muslim',
        ),
        AdhkarItem(
          arabicText:
              'اللَّهُمَّ أَعِنِّي عَلَىٰ ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ.',
          translationEn:
              'O Allah, help me to remember You, to give You thanks, and to perform Your worship in the best manner.',
          translationFr:
              'Ô Allah, aide-moi à me souvenir de Toi, à Te remercier et à T\'adorer de la meilleure façon.',
          repeatCount: 1,
          reference: 'Abu Dawud & An-Nasa\'i',
        ),
      ],
    ),
  ];
}