class OpenWeather {
  String weather;
  String description;
  double temperature;
  double temperatureMin;
  double temperatureMax;
  double temperatureFeelsLike;
  OpenWeather.fromJson(Map<String, dynamic> json)
      : weather = json['weather'][0]['main'],
        description = json['weather'][0]['description'],
        temperature = json['main']['temp'],
        temperatureMin = json['main']['temp_min'],
        temperatureMax = json['main']['temp_max'],
        temperatureFeelsLike = json['main']['feels_like'];
  String get temperatureCelsius => (temperature - 273.15).toStringAsFixed(2);
  String get temperatureMinCelsius =>
      (temperatureMin - 273.15).toStringAsFixed(2);
  String get temperatureMaxCelsius =>
      (temperatureMax - 273.15).toStringAsFixed(2);
  String get temperatureFeelsLikeCelsius =>
      (temperatureFeelsLike - 273.15).toStringAsFixed(2);
  String get icon {
    switch (weather) {
      case 'Clear':
        return 'images/sunny-day.png';
        break;
      case 'Rain':
        return 'images/rainy.png';
        break;
      case 'Clouds':
        return ((DateTime.now().hour > 19) || (DateTime.now().hour < 4))
            ? 'images/cloudy-moon.png'
            : 'images/cloudy-day.png';
        break;
      default:
        return '';
        break;
    }
  }
}
