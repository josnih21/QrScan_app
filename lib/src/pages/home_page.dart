import 'package:flutter/material.dart';
import 'package:qrscanner_sql/src/bloc/scans_bloc.dart';
import 'package:qrscanner_sql/src/models/scan_models.dart';
import 'package:qrscanner_sql/src/pages/adresses.dart';
import 'package:qrscanner_sql/src/pages/maps.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {scansBloc.deleteAllScans();},
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index); 
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Maps')),
          BottomNavigationBarItem(
              icon: Icon(Icons.brightness_5), title: Text('Adresses')),
        ]);
  }
  //https://josnih.com
  //geo:40.65967463655211,-73.92354383906253
  _scanQR() async {
    dynamic futureString = 'https://josnih.com';
    //try {
      //futureString = await BarcodeScanner.scan();
    //} catch (e) {
      //futureString = e.toString();
    //}

    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      scansBloc.addScans(scan);
    }
  }

  Widget _callPage(int actualPage) {
    switch (actualPage) {
      case 0:
        return MapsPage();
        break;

      case 1:
        return AdressesPage();
        break;

      default:
        return MapsPage();
    }
  }
}
