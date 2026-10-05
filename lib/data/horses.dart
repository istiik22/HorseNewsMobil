class Horse {
  final String name;
  final String breed;
  final String fact;
  // пофиксить: пока пусто, потом подставим ассет или network url
  // вариант 1 - локальные png в assets/horses/
  // вариант 2 - svg через flutter_svg (легче по весу, ты это в планах отметила)
  final String imageAsset;

  const Horse({
    required this.name,
    required this.breed,
    required this.fact,
    required this.imageAsset,
  });
}

// временный локальный список. потом можно тянуть с api или из firestore
const List<Horse> horses = [
  Horse(
    name: 'Ахалтекинец',
    breed: 'Ахалтекинская',
    fact: 'Одна из древнейших пород, известна своей выносливостью в пустыне.',
    imageAsset: '',
  ),
  Horse(
    name: 'Ганновер',
    breed: 'Ганноверская',
    fact: 'Универсальная спортивная порода, часто выступает в выездке и конкуре.',
    imageAsset: '',
  ),
  Horse(
    name: 'Орловский рысак',
    breed: 'Орловская рысистая',
    fact: 'Выведена в России графом Орловым, славится устойчивой рысью.',
    imageAsset: '',
  ),
  Horse(
    name: 'Арабский скакун',
    breed: 'Арабская чистокровная',
    fact: 'Одна из самых узнаваемых пород, легко отличить по вогнутому профилю.',
    imageAsset: '',
  ),
  Horse(
    name: 'Будённовская',
    breed: 'Будённовская',
    fact: 'Создана для кавалерии, сейчас успешна в троеборье.',
    imageAsset: '',
  ),
];