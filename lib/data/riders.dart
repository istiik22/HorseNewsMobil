class Rider {
  final String name;
  final String country;
  final String discipline;
  final int points;
  final int rank;

  const Rider({
    required this.name,
    required this.country,
    required this.discipline,
    required this.points,
    required this.rank,
  });
}

// пофиксить: цифры выдуманы для верстки, потом заменить на реальные с fei.org
// вариант 2 - дергать открытый api, если найдёшь (у fei вроде нет публичного)
const List<Rider> topRiders = [
  Rider(rank: 1, name: 'Хенрик фон Эккерман', country: 'SWE', discipline: 'Конкур', points: 3280),
  Rider(rank: 2, name: 'Джессика фон Бредов-Верндль', country: 'GER', discipline: 'Выездка', points: 3155),
  Rider(rank: 3, name: 'Роз Кантёр', country: 'GBR', discipline: 'Троеборье', points: 3021),
  Rider(rank: 4, name: 'Стив Герда', country: 'SUI', discipline: 'Конкур', points: 2970),
  Rider(rank: 5, name: 'Шарлотта Фрай', country: 'GBR', discipline: 'Выездка', points: 2890),
];

const List<String> disciplines = [
  'Все',
  'Конкур',
  'Выездка',
  'Троеборье',
  'Вестерн',
  'Скачки',
];