import 'package:sqflite/sqflite.dart';

class ConnectionDB {
  //create based on singlenton approach (the same instance for avoid memory leak)
  static final ConnectionDB _connectionDB = new ConnectionDB._internal();

  factory ConnectionDB() {
    return _connectionDB;
  }

  ConnectionDB._internal();

  //starts connection with database only one single time with singlenton approach
  static Database _database;

  static Future<Database> connect() async {
    if (_database != null) {
      return _database;
    }
  }
}
