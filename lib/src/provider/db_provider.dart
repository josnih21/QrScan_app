import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrscanner_sql/src/models/scan_models.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async{
    if(database !=null){
      return _database;
    }

    _database = await initDB();
    return _database;
  }
    
  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path,'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db,int version) async {
        await db.execute(
          'CRETE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')'
        );
      }
    );
  }

  //INSERT
  newScanRaw(ScanModel nuevoScan) async {
    final db  = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  //SELECT 
  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null; 
  }

  Future<List<ScanModel>> getAllScans() async{
    final db = await database;
    final res = await db.query('Scans');
    List<ScanModel> list = res.isNotEmpty ? res.map((scan) => ScanModel.fromJson(scan)).toList() : [];
    return list;
  }

    Future<List<ScanModel>> getAllScansByType(String type) async{
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$type'");
    List<ScanModel> list = res.isNotEmpty ? res.map((scan) => ScanModel.fromJson(scan)).toList() : [];
    return list;
  }
}