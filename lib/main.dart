import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/library_screen.dart';
import 'screens/news_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int index = 0;

  // держим экраны в списке, чтобы состояние не терялось
  // вариант 2 - использовать IndexedStack, он то же самое делает, но проще
  final pages = const [
    HomeScreen(),
    LibraryScreen(),
    NewsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(
            label: 'Главная',
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Библиотека',
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
          ),
          BottomNavigationBarItem(
            label: 'Новости',
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
          ),
        ],
      ),
    );
  }
}