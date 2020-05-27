import 'dart:async';

import 'package:qrscanner_sql/src/provider/db_provider.dart';

class ScansBloc {
  
  static final ScansBloc _singleton = new ScansBloc._internal();
  
    factory ScansBloc(){
      return _singleton;
    }
    ScansBloc._internal(){
      //get scans from Database
      getScans();
    }

    final _scansController = new StreamController<List<ScanModel>>.broadcast();

    Stream<List<ScanModel>> get scansStream => _scansController.stream;

    dispose() {
      _scansController?.close();
    }

    addScans(ScanModel scan) async{
      await DBProvider.db.newScanRaw(scan);
      getScans();
    }

    getScans() async {
      _scansController.sink.add(await DBProvider.db.getAllScans());
    }

    deleteScan(int id) async{
      await DBProvider.db.deleteScan(id);
      getScans();
    }

    deleteAllScans() async{
      await DBProvider.db.deleteAll();
      getScans();
    }

}