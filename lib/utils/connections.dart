import 'package:sqflite/sqflite.dart';

class ConnectionDB {
  //create based on singlenton approach (the same instance for avoid memory leak)
  static final ConnectionDB _connectionDB = new ConnectionDB._internal();

  factory ConnectionDB() {
    return _connectionDB;
  }

  ConnectionDB._internal();

  
}
