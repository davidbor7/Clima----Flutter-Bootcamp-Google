import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper{

  NetworkHelper(this.url);

  final String url;

  Future getData() async {

    http.Response response = await http.get(url);
  
    if(response.statusCode == 200){ //La petición http ha sido satisfactoria
      String data = response.body;
      //print('Llamada a la API correcta'); //String con datos json

      var decodedData = jsonDecode(data); //Conversión del String de datos a tipo JSON
      return decodedData;

    }else {
      print(response.statusCode);
    }
  }
}