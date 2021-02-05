//db helpers - to be used for the database conenction and interactions
//import packages
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:invoices_app/model/invoice.dart';

//Matches the Database columns and fleeds, this class will be instanciated only once - means a Singleton
//Use the factory keyword to always return the same instance of a class
class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  String tblInvoice = "invoice";
  String colId = "id";
  String colVatnumber = "vatnumber";
  String colAmount = "amount";
  String colDescription = "description";
  String colTitle = "title";
  String colPriority = "priority";
  String colDate = "date";

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  //Variable that will contain the db throughout the class
  static Database _db;

  //Getter that will check if db is null or await for the initializeDb();
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  //Future method, it will get a value in the future
  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "invoices.db";
    var dbInvoices = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbInvoices;
  }

  //Create the actual database
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblInvoice($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +
            "$colVatnumber TEXT, $colAmount TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)");
  }

  //Query methods
  //Insert query
  Future<int> insertInvoice(Invoice invoice) async {
    Database db = await this.db;
    var result = await db.insert(tblInvoice, invoice.toMap());
    return result;
  }

  //Select query
  Future<List> getInvoices() async {
    Database db = await this.db;
    var result = await db
        .rawQuery("SELECT * FROM $tblInvoice order by $colPriority ASC");
    return result;
  }

  //Get the number of invoices
  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT count (*) from $tblInvoice"));
    return result;
  }

  //Update query
  Future<int> updateInvoice(Invoice invoice) async {
    var db = await this.db;
    var result = await db.update(tblInvoice, invoice.toMap(),
        where: "$colId=?", whereArgs: [invoice.id]);
    return result;
  }

  //Delete query
  Future<int> deleteInvoice(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblInvoice WHERE $colId =$id');
    return result;
  }
}

//Go to main.dart to import the model and dbhelper class and use it
