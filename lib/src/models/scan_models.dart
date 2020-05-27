import 'package:latlong/latlong.dart';

class ScanModel {
    int id;
    String type;
    String value;

    ScanModel({
        this.id,
        this.type,
        this.value,
    }){
      if(this.value.contains('http')){
        this.type = 'http';
      }else{
        this.type = 'geo';
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id    : json["id"],
        type  : json["tipo"],
        value : json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id"    : id,
        "tipo"  : type,
        "valor" : value,
    };

    LatLng getCoords (){
      final latlong = value.substring(4).split(',');
      final lat = double.parse(latlong[0]);
      final long = double.parse(latlong[1]);
      return LatLng(lat,long);
    }
}
