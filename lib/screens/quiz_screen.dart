import 'package:flutter/material.dart';
import '../data/library_data.dart';
import '../theme/app_theme.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // 0 - выбор тем, 1 - прохождение теста, 2 - результаты
  int screenState = 0;

  final List<String> selectedCategories = [];

  List<QuizQuestion> generatedQuestions = [];

  int currentQuestionIndex = 0;
  int score = 0;

  late List<String> availableCategories;

  @override
  void initState() {
    super.initState();
    availableCategories = allQuizQuestions.map((q) => q.category).toSet().toList();
  }

  void _startQuiz() {
    if (selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выбери хотя бы одну тему!')),
      );
      return;
    }

    final filtered = allQuizQuestions.where((q) => selectedCategories.contains(q.category)).toList();
    
    filtered.shuffle();

    setState(() {
      generatedQuestions = filtered;
      currentQuestionIndex = 0;
      score = 0;
      screenState = 1;
    });
  }

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == generatedQuestions[currentQuestionIndex].correctAnswerIndex) {
      score++;
    }

    if (currentQuestionIndex < generatedQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      setState(() {
        screenState = 2; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (screenState == 0) return _buildSelectionScreen();
    if (screenState == 1) return _buildQuizScreen();
    return _buildResultScreen();
  }

  // выборка темы
  Widget _buildSelectionScreen() {
    return Scaffold(
      appBar: AppBar(title: const Text('Проверка знаний')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Что проверим?', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text('Выбери темы, и мы сгенерируем тест', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            ...availableCategories.map((cat) {
              final isSelected = selectedCategories.contains(cat);
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.surfaceAlt : AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppColors.gold : AppColors.border),
                ),
                child: CheckboxListTile(
                  title: Text(cat, style: const TextStyle(color: AppColors.text)),
                  value: isSelected,
                  activeColor: AppColors.gold,
                  checkColor: AppColors.bg,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedCategories.add(cat);
                      } else {
                        selectedCategories.remove(cat);
                      }
                    });
                  },
                ),
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.bg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _startQuiz,
                child: const Text('Сгенерировать тест', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // второй экран - когда проходим
  Widget _buildQuizScreen() {
    final question = generatedQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Вопрос ${currentQuestionIndex + 1} из ${generatedQuestions.length}'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => setState(() => screenState = 0), // выйти
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // индикатор прогресса
            LinearProgressIndicator(
              value: (currentQuestionIndex) / generatedQuestions.length,
              backgroundColor: AppColors.surfaceAlt,
              color: AppColors.gold,
              minHeight: 6,
            ),
            const SizedBox(height: 30),
            
            // категория вопроса
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(question.category, style: const TextStyle(color: AppColors.gold, fontSize: 12)),
            ),
            const SizedBox(height: 16),
            
            Text(question.question, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 30),

            // варианты ответов
            ...List.generate(question.options.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => _answerQuestion(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.textMuted),
                          ),
                          child: Text(String.fromCharCode(65 + index), style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(question.options[index], style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ---- ЭКРАН 3: РЕЗУЛЬТАТЫ ----
  Widget _buildResultScreen() {
    final total = generatedQuestions.length;
    final percent = (score / total * 100).round();

    String message;
    if (percent == 100) {
      message = 'Идеально! Ты настоящий эксперт.';
    } else if (percent >= 70) {
      message = 'Отличный результат! Есть куда расти.';
    } else {
      message = 'Неплохо для начала, но стоит повторить теорию.';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Результаты')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // большой круг с процентами
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.gold, width: 4),
                ),
                child: Center(
                  child: Text(
                    '$percent%',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text('Правильных ответов: $score из $total', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.bg,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    setState(() {
                      screenState = 0; // вернуться к выбору тем
                      selectedCategories.clear();
                    });
                  },
                  child: const Text('Пройти еще раз', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}