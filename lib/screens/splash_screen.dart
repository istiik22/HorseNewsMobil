import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // предзагружаем гифку в память до того, как она появится на экране
    // это уберет "зависание" и рывок в самом начале
    _precacheImage();

    // через 2.5 секунды переходим на главный экран
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const Root(),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  // функция для предзагрузки картинки
  void _precacheImage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(
        const AssetImage('assets/icon/horse_run.gif'), 
        context
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // фоновое свечение
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gold.withValues(alpha: 0.15),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
                // лоадер
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    color: AppColors.gold,
                    strokeWidth: 2,
                    backgroundColor: AppColors.surfaceAlt,
                  ),
                ),
                // гифка
                // gaplessPlayback: true не дает гифке мигать при перерисовке экрана
                Image.asset(
                  'assets/icon/horse_run.gif',
                  width: 90,
                  fit: BoxFit.contain,
                  gaplessPlayback: true, 
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'Конный спорт',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.text,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}