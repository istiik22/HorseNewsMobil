import 'package:flutter/material.dart';
import '../data/weather.dart';
import '../theme/app_theme.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  City currentCity = cities['moscow']!;
  Weather? weather;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadWeather(currentCity);
  }

  Future<void> _loadWeather(City city) async {
    setState(() {
      isLoading = true;
      error = null;
      currentCity = city;
    });

    try {
      final w = await fetchWeather(city);
      if (mounted) {
        setState(() {
          weather = w;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = 'Ошибка загрузки: $e';
          isLoading = false;
        });
      }
    }
  }

  IconData _getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case 'clear': return Icons.wb_sunny_outlined;
      case 'rain': return Icons.water_drop_outlined;
      case 'snow': return Icons.ac_unit;
      case 'storm': return Icons.flash_on_outlined;
      default: return Icons.cloud_outlined;
    }
  }

  Color _getWeatherColor(String iconCode) {
    switch (iconCode) {
      case 'clear': return AppColors.gold; // солнце - золото
      case 'rain': return const Color(0xFF7E9EBF); // дождь - холодный синий
      case 'snow': return Colors.white70;
      case 'storm': return Colors.deepPurpleAccent;
      default: return AppColors.textMuted; // облака - серый
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgGradient = LinearGradient(
      colors: [AppColors.surface, AppColors.surfaceAlt],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: bgGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // верхняя строка: заголовок и дропдаун
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Погода на конюшне',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    letterSpacing: 0.5,
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: cities.entries.firstWhere((e) => e.value.name == currentCity.name).key,
                    dropdownColor: AppColors.surfaceAlt,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.gold, size: 18),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.goldSoft,
                      fontWeight: FontWeight.w600,
                    ),
                    items: cities.entries.map((e) {
                      return DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value.name),
                      );
                    }).toList(),
                    onChanged: (key) {
                      if (key != null) _loadWeather(cities[key]!);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CircularProgressIndicator(color: AppColors.gold, strokeWidth: 2),
                ),
              )
            else if (error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(error!, style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
              )
            else if (weather != null) ...[
              Row(
                children: [
                  Icon(
                    _getWeatherIcon(weather!.icon),
                    size: 52,
                    color: _getWeatherColor(weather!.icon),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${weather!.temperature.toStringAsFixed(1)}°C',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.text,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Ветер: ${weather!.windSpeed.toStringAsFixed(1)} м/с',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.05),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline, color: AppColors.gold, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        weather!.recommendation,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.goldSoft,
                          height: 1.5,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}