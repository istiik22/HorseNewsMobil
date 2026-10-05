import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // пофиксить: заглушка, потом сюда результаты турниров и календарь
    return Scaffold(
      appBar: AppBar(title: const Text('Новости')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.article_outlined,
                  size: 40, color: AppColors.textMuted),
              const SizedBox(height: 12),
              Text(
                'Календарь соревнований и результаты\nпоявятся здесь',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}