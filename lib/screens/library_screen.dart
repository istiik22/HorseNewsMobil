import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  // пофиксить: пока просто заготовка, разделы не открываются
  // вариант 1 - сделать сетку из карточек и открывать по тапу
  // вариант 2 - сделать список с раскрывающимися секциями
  static const sections = [
    ('Породы', 'Описание, характер, применение'),
    ('Амуниция', 'Сёдла, уздечки, вальтрапы'),
    ('Уход', 'Чистка, копыта, грива'),
    ('Кормление', 'Рационы, подкормки'),
    ('Болезни', 'Симптомы и первая помощь'),
    ('Термины', 'Словарь конной терминологии'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Библиотека')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final (title, subtitle) = sections[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right,
                    color: AppColors.textMuted),
              ],
            ),
          );
        },
      ),
    );
  }
}