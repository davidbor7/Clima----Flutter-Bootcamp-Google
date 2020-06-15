import 'dart:math';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();

  LocationScreen({this.locationWeather});

  final locationWeather;
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String cityName;
  WeatherModel weather = WeatherModel();
  String weatherIcon;
  String weatherMessage;
  int numeroImage;
  int tap = 0;

  @override
  void initState() {
    super.initState();
    createRandom();
    updateUI(widget.locationWeather);
    BackButtonInterceptor.add(myInterceptor);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'No se ha obtenido acceso al tiempo';
        cityName = '';
      }
      createRandom();
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(weatherData['weather'][0]['id']);
      weatherMessage = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //Evitar errores de renderizado al abrir teclado y navegar a otra ventana
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if(typedName != null){
                         var weatherData = await weather.getCityWeather(typedName);
                         if(weatherData != null){
                           updateUI(weatherData);
                         }                        
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: AutoSizeText(
                  "$weatherMessage en $cityName",
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int createRandom() {
    var rng = new Random();
    numeroImage = rng.nextInt(6) + 1;
    return numeroImage;
  }
  bool myInterceptor(bool stopDefaultButtonEvent) {
    tap++;
    if(tap == 2){
      tap= 0;
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    return true;    
  }
}
