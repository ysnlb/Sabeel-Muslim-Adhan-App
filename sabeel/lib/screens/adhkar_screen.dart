import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/adhkar_data.dart';
import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';

class AdhkarScreen extends ConsumerWidget {
  const AdhkarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(settingsProvider).locale;
    final categories = AdhkarRepository.categories;

    return DefaultTabController(
      length: categories.length,
      child: Column(
        children: [
          // Tab bar
          Material(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              indicatorColor: const Color(0xFFD4A843),
              tabs: categories.map((c) {
                final label = locale == 'ar'
                    ? c.keyAr
                    : locale == 'fr'
                        ? c.keyFr
                        : c.keyEn;
                return Tab(text: label);
              }).toList(),
            ),
          ),
          // Tab content
          Expanded(
            child: TabBarView(
              children: categories.map((cat) {
                return _AdhkarList(category: cat, locale: locale);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdhkarList extends StatefulWidget {
  final AdhkarCategory category;
  final String locale;

  const _AdhkarList({required this.category, required this.locale});

  @override
  State<_AdhkarList> createState() => _AdhkarListState();
}

class _AdhkarListState extends State<_AdhkarList>
    with AutomaticKeepAliveClientMixin {
  late List<int> _counters;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _counters =
        widget.category.items.map((i) => i.repeatCount).toList();
  }

  void _decrement(int index) {
    if (_counters[index] > 0) {
      setState(() => _counters[index]--);
    }
  }

  void _resetAll() {
    setState(() {
      for (int i = 0; i < _counters.length; i++) {
        _counters[i] = widget.category.items[i].repeatCount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      children: [
        // Reset button
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            onPressed: _resetAll,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Reset'),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            itemCount: widget.category.items.length,
            itemBuilder: (context, index) {
              final item = widget.category.items[index];
              final remaining = _counters[index];
              final done = remaining == 0;

              return GestureDetector(
                onTap: () => _decrement(index),
                child: Card(
                  color: done
                      ? theme.colorScheme.primary.withOpacity(0.08)
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Arabic text – always RTL
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            item.arabicText,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1.8,
                              color: done
                                  ? theme.colorScheme.primary
                                  : null,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Translation
                        Text(
                          widget.locale == 'fr'
                              ? item.translationFr
                              : widget.locale == 'ar'
                                  ? '' // Arabic readers may not need translation
                                  : item.translationEn,
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.textTheme.bodySmall?.color,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Counter & reference
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (item.reference != null)
                              Text(
                                item.reference!,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: theme.hintColor),
                              ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: done
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.primary
                                        .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '$remaining / ${item.repeatCount}',
                                style: TextStyle(
                                  color: done
                                      ? Colors.white
                                      : theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}