import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrscanner_sql/src/models/scan_models.dart';
import 'package:latlong/latlong.dart';
class MapPage extends StatelessWidget {
  final MapController map = new MapController();
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.my_location),
          onPressed: (){
            map.move(scan.getCoords(), 10);
          },
          )
        ],
      ),
      body: _createFlutterMap(scan),
    );
  }

 Widget _createFlutterMap(ScanModel scan) {
  return new FlutterMap(
    mapController: map,
    options: new MapOptions(
      center: scan.getCoords(),
      zoom: 10
    ),
    layers: [
      _createMap(),
      _createMarker(scan),
    ],
  );
 }

  _createMap() {
    return TileLayerOptions(
      maxNativeZoom: 18,
      urlTemplate: 'https://api.mapbox.com/styles/v1/'
                  '{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
        additionalOptions: {
        'accessToken':'pk.eyJ1Ijoiam9zbmloIiwiYSI6ImNrYXBncno4czFkbW0ycnFtMjQzc3gyYzEifQ.APwKt9IGFXculR0E_W-KWg',
        'id': 'mapbox/streets-v11' //streets,dark,light, outdoors, satellite
        }
    );
  }

  _createMarker(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getCoords(),
          builder: (context) => Container(
            child: Icon(Icons.location_on,size:70.0,color: Theme.of(context).primaryColor)
          )
        )
      ]
    );
  }
}