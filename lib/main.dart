import 'package:flutter/material.dart';
import 'package:qrscanner_sql/src/pages/adresses.dart';
import 'package:qrscanner_sql/src/pages/home_page.dart';
import 'package:qrscanner_sql/src/pages/maps.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.greenAccent
      ),
    );
  }
}