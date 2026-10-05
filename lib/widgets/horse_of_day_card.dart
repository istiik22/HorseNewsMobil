import 'package:flutter/material.dart';
import '../data/horses.dart';
import '../theme/app_theme.dart';

class HorseOfDayCard extends StatefulWidget {
  const HorseOfDayCard({super.key});

  @override
  State<HorseOfDayCard> createState() => _HorseOfDayCardState();
}

class _HorseOfDayCardState extends State<HorseOfDayCard> {
  late Horse horse;

  @override
  void initState() {
    super.initState();
    // выбираем лошадь один раз при загрузке экрана,
    // чтобы не прыгала при каждом build
    horse = horses[DateTime.now().day % horses.length];
  }

  void shuffle() {
    setState(() {
      horse = (horses..shuffle()).first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // пофиксить: пока заглушка вместо картинки
          // когда появятся ассеты - заменить на Image.asset / Image.network
          Container(
            height: 140,
            decoration: const BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Center(
              child: Icon(
                Icons.photo_camera_back_outlined,
                color: AppColors.textMuted,
                size: 32,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Лошадь дня',
                        style: Theme.of(context).textTheme.bodySmall),
                    GestureDetector(
                      onTap: shuffle,
                      child: const Icon(Icons.refresh,
                          color: AppColors.gold, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(horse.name,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 2),
                Text(horse.breed,
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 10),
                Text(horse.fact,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}