import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    //get path of database on local storage (please make attention if you use Android and iOS)
    var databasePath = await getDatabasesPath();
    //concat db local with new db for this app
    final String path = join(databasePath, 'flusqlStore1.db');

    //open connection
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      //run sql commands with .execute()
      db.execute(
          'CREATE TABLE people (id INTEGER PRIMARY KEY, name TEXT, email TEXT, enabled INTEGER)');
    });

    return _database;
  }
}
