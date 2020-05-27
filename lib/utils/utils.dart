import 'package:flutter/material.dart';
import 'package:qrscanner_sql/src/models/scan_models.dart';
import 'package:url_launcher/url_launcher.dart';

lauchURL(BuildContext context,ScanModel scan) async {
  if(scan.type == 'http'){
    if(await canLaunch(scan.value)){
      await launch(scan.value);
    }else{
      throw 'Could not lauch ${scan.value}';
    }

  }else{
    Navigator.pushNamed(context, 'mapa',arguments: scan);
  }
}