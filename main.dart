import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Конный спорт'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Добро пожаловать!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text('Последние соревнования',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.brown.shade50,
              child: const Center(
                child: Text('тут будет текст о соревнованиях'),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Фото победителей', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Container(
              height: 120,
              width: double.infinity,
              color: Colors.brown.shade50,
              child: const Center(child: Text('тут будут фото')),
            ),
            const SizedBox(height: 20),

            const Text('Из библиотеки', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.brown.shade50,
              child: const Center(child: Text('тут будут книги и статьи')),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.brown,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        items: const [
          BottomNavigationBarItem(label: 'Главная', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Библиотека', icon: Icon(Icons.book)),
          BottomNavigationBarItem(label: 'Новости', icon: Icon(Icons.article)),
        ],
      ),
    );
  }
}