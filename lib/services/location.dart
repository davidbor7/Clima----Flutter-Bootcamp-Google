import 'package:geolocator/geolocator.dart';

class Location{

  double latitude;
  double longitude;
  Position position;

  Future<void> getCurretnLocation() async {
    try{
      position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;   
    }catch(e){
      print(e);
    }
  }
}