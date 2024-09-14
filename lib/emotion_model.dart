class FeelingsModel {
  final String name;
  final String iconPath;
  final List<String> subFeel;

  FeelingsModel(
      {required this.name, required this.iconPath, required this.subFeel});

  static List<FeelingsModel> getFeelings() {
    List<FeelingsModel> feelings = [];

    feelings.add(FeelingsModel(
        name: 'Радость',
        iconPath: 'assets/icons/photo_1_2024-09-14_01-10-01.jpg',
        subFeel: [
          'Возбуждение',
          'Восторг',
          'Игривость',
          'Очарование',
          'Наслаждение',
          'Смелость',
          'Удовольствие',
          'Энергичность',
        ]));
    feelings.add(FeelingsModel(
        name: 'Страх',
        iconPath: 'assets/icons/photo_4_2024-09-14_01-10-01.jpg',
        subFeel: [
          'Неизвестность',
          'Тревога',
          'Нервозность',
          'Паника',
          'Ужас',
          'Боязнь',
        ]));
    feelings.add(FeelingsModel(
        name: 'Бешенство',
        iconPath: 'assets/icons/photo_3_2024-09-14_01-10-01.jpg',
        subFeel: [
          'Раздражение',
          'Гнев',
          'Ненависть',
          'Отчаянье',
        ]));
    feelings.add(FeelingsModel(
        name: 'Грусть',
        iconPath: 'assets/icons/photo_6_2024-09-14_01-10-01.jpg',
        subFeel: [
          'Тоска',
          'Одиночество',
          'Сожаление',
          'Уныние',
        ]));
    feelings.add(FeelingsModel(
        name: 'Спокойствие',
        iconPath: 'assets/icons/photo_2_2024-09-14_01-10-01.jpg',
        subFeel: [
          'Расслабление',
          'Умиротворение',
          'Безмятежность',
          'Комфорт',
        ]));
    feelings.add(FeelingsModel(
        name: 'Сила',
        iconPath: 'assets/icons/photo_5_2024-09-14_01-10-01.jpg',
        subFeel: [
          'Энергия',
          'Уверенность',
          'Мощь',
          'Смелость',
          'Оптимизм',
        ]));
    return feelings;
  }
}
