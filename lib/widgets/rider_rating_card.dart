import 'package:flutter/material.dart';
import '../data/riders.dart';
import '../theme/app_theme.dart';

class RiderRatingCard extends StatefulWidget {
  const RiderRatingCard({super.key});

  @override
  State<RiderRatingCard> createState() => _RiderRatingCardState();
}

class _RiderRatingCardState extends State<RiderRatingCard> {
  String selected = 'Все';

  @override
  Widget build(BuildContext context) {
    final filtered = selected == 'Все'
        ? topRiders
        : topRiders.where((r) => r.discipline == selected).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Топ всадников FEI',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: disciplines.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final d = disciplines[i];
                final active = d == selected;
                return GestureDetector(
                  onTap: () => setState(() => selected = d),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: active ? AppColors.gold : Colors.transparent,
                      border: Border.all(
                        color: active ? AppColors.gold : AppColors.border,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      d,
                      style: TextStyle(
                        color: active ? AppColors.bg : AppColors.textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          // пофиксить: если фильтр пустой, покажется пусто - надо empty state
          // вариант 2 - прятать фильтр, если ничего не найдено
          ...filtered.map((r) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Text(
                        '${r.rank}',
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.name,
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text('${r.country} · ${r.discipline}',
                              style:
                                  Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    Text('${r.points}',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}