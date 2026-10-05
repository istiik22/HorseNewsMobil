class Competition {
  final String title;
  final String place;
  final DateTime date;

  const Competition({
    required this.title,
    required this.place,
    required this.date,
  });
}

// пофиксить: дата захардкожена, обратный отсчёт будет всегда на неё
// вариант 1 - считать ближайшую из списка динамически (уже так и сделано ниже)
// вариант 2 - тянуть с api календаря
List<Competition> upcoming() {
  final now = DateTime.now();
  return [
    Competition(
      title: 'Этап Кубка России по конкуру',
      place: 'Москва',
      date: now.add(const Duration(days: 12, hours: 5)),
    ),
    Competition(
      title: 'Международный турнир по выездке',
      place: 'Санкт-Петербург',
      date: now.add(const Duration(days: 34)),
    ),
    Competition(
      title: 'Троеборье: весенний кубок',
      place: 'Казань',
      date: now.add(const Duration(days: 58)),
    ),
  ];
}

Competition nearest() {
  final list = upcoming()..sort((a, b) => a.date.compareTo(b.date));
  return list.first;
}