import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';

const apiKey = '3ff2e0325ddfa94d64e8ad5aca36cbbb';

class WeatherModel {


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }


  String getMessage(int temp) {
    if (temp > 35) {
      return 'Es hora de pisar la playa ⛱️🌞👙🌊';
    } else if (temp > 23) {
      return 'La 🌡️ perfecta para dar un paseo';
    } else if (temp < 10) {
      return 'Vas a necesitar 🧣🧤';
    } else {
      return 'Coge una 🧥 hará algo de fresco';
    }
  }
  
  Future<dynamic> getLocationWeather() async {

    Location location = Location();
    await location.getCurretnLocation();

    NetworkHelper networkHelper = NetworkHelper('http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;
    
  }

  Future<dynamic> getCityWeather(String cityName) async {

    NetworkHelper networkHelper = NetworkHelper('http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;
    
  }

}
