import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {

  String valueText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Obtener tiempo de:',
                  style: kButtonTextStyle,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 60, 20),
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    hintText: 'Ciudad',
                    hintStyle: TextStyle(
                      color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),        
                      borderSide: BorderSide.none        
                    ),
                  ),
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0
                  ),
                  onChanged: (value) async{
                    valueText = value.replaceAll('á', 'a').replaceAll('é', 'e').replaceAll('í', 'i').replaceAll('ó', 'o').replaceAll('ú', 'u').replaceAll('Á', 'A').replaceAll('É', 'E').replaceAll('Í', 'I').replaceAll('Ó', 'O').replaceAll('Ú', 'U');
                  },
                ),
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: () async {
                  Navigator.pop(context, valueText);
                },
                child: Text(
                  'Obtener',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
