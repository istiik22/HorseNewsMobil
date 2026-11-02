import 'dart:convert';
import 'package:http/http.dart' as http;

class City {
  final String name;
  final double lat;
  final double lon;

  const City({required this.name, required this.lat, required this.lon});
}

const cities = {
  'moscow': City(name: 'Москва', lat: 55.7558, lon: 37.6173),
  'spb': City(name: 'Санкт-Петербург', lat: 59.9343, lon: 30.3351),
  'vladikavkaz': City(name: 'Владикавказ', lat: 43.0367, lon: 44.6678),
};

class Weather {
  final double temperature;
  final int weatherCode;
  // добавим скорость ветра, для конюшни это важно (бочка, манеж)
  final double windSpeed;

  Weather({
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
  });

  String get recommendation {
    // пофиксить: коды wmo тут базовые, можно расширить (гроза, ливень и тд)
    // вариант 2 - вынести в отдельный класс WeatherAdvisor
    bool isBadWeather = weatherCode >= 51 && weatherCode <= 67 || 
                        weatherCode >= 71 && weatherCode <= 77 || 
                        weatherCode >= 80;

    if (isBadWeather || windSpeed > 10) {
      return 'Погода не для улицы. Сегодня лучше потренироваться в крытом манеже или дать лошади отдых.';
    }

    if (temperature < 0) {
      return 'Морозно. Отличный день для тренировки на поле, но следите за дыханием лошади и не переусердствуйте с разминкой.';
    }

    if (temperature > 25) {
      return 'Жарко. Лучше перенести тренировку на утро или вечер. Солнце сияет, не забудьте взять кепку под шлем.';
    }

    if (windSpeed > 5) {
      return 'Ветрено. Отличный день для тренировки в бочке или работы без стремян, чтобы улучшить баланс.';
    }

    return 'Отличный день для тренировки на открытом поле! Идеальные условия, чтобы отработать элементы конкура.';
  }

  String get icon {
    if (weatherCode == 0) return 'clear';
    if (weatherCode >= 1 && weatherCode <= 3) return 'cloudy';
    if (weatherCode >= 51 && weatherCode <= 67) return 'rain';
    if (weatherCode >= 71 && weatherCode <= 77) return 'snow';
    if (weatherCode >= 95) return 'storm';
    return 'cloudy';
  }
}

Future<Weather> fetchWeather(City city) async {
  final url = Uri.parse(
    'https://api.open-meteo.com/v1/forecast'
    '?latitude=${city.lat}&longitude=${city.lon}'
    '&current=temperature_2m,weather_code,wind_speed_10m'
    '&timezone=Europe/Moscow',
  );

  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception('HTTP ${response.statusCode}');
  }

  final data = jsonDecode(response.body);

  // проверяем, что ключ current вообще есть
  if (data['current'] == null) {
    throw Exception('Нет поля current в ответе');
  }

  final current = data['current'];

  return Weather(
    temperature: (current['temperature_2m'] as num?)?.toDouble() ?? 0.0,
    weatherCode: (current['weather_code'] as num?)?.toInt() ?? 0,
    windSpeed: (current['wind_speed_10m'] as num?)?.toDouble() ?? 0.0,
  );
}