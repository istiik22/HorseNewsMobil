import 'package:flutter/material.dart';
import '../widgets/horse_of_day_card.dart';
import '../widgets/countdown_card.dart';
import '../widgets/rider_rating_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Конный спорт')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: const [
          CountdownCard(),
          SizedBox(height: 16),
          HorseOfDayCard(),
          SizedBox(height: 16),
          RiderRatingCard(),
        ],
      ),
    );
  }
}