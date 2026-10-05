import 'dart:async';
import 'package:flutter/material.dart';
import '../data/competitions.dart';
import '../theme/app_theme.dart';

class CountdownCard extends StatefulWidget {
  const CountdownCard({super.key});

  @override
  State<CountdownCard> createState() => _CountdownCardState();
}

class _CountdownCardState extends State<CountdownCard> {
  late Competition comp;
  late Duration left;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    comp = nearest();
    _tick();
    // обновляем раз в минуту, секунды не нужны - смысла нет
    // пофиксить: если пользователь свернёт приложение, таймер может подтормаживать
    // вариант 2 - пересчитывать при возврате через WidgetsBindingObserver
    timer = Timer.periodic(const Duration(minutes: 1), (_) => _tick());
  }

  void _tick() {
    final d = comp.date.difference(DateTime.now());
    if (!mounted) return;
    setState(() => left = d.isNegative ? Duration.zero : d);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String _fmt() {
    final days = left.inDays;
    final hours = left.inHours % 24;
    final mins = left.inMinutes % 60;
    return '$days д $hours ч $mins мин';
  }

  @override
  Widget build(BuildContext context) {
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
          Text('Ближайшее соревнование',
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 6),
          Text(comp.title, style: Theme.of(context).textTheme.titleMedium),
          Text(comp.place, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          Text(
            _fmt(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.gold,
                ),
          ),
        ],
      ),
    );
  }
}